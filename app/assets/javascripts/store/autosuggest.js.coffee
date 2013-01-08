class @Autosuggest
  constructor: (selector, options = {}) ->
    @search_field = $(selector)
    return if @search_field.length == 0

    @settings =
      from_db: 15
      to_display: 5
    @settings = $.extend @settings, options

    @cache = {}

    $.extend true, $.ui.autocomplete::, @extension_methods()
    @search_field.autocomplete(
      @settings,
      source: (request, response) =>
        @finder(request, response))
      .bind "keydown.autocomplete", (event) =>
        @fire_keybinds(event)

  # TODO: rewrite
  fire_keybinds: (event) ->
    if event.keyCode == $.ui.keyCode.RIGHT
      elem = $(@search_field.data('autocomplete').menu.active).find('a')
      if elem.length > 0
        elem.trigger('click')
      else
        $('li.ui-menu-item:first a').trigger('mouseenter').trigger('click')

  finder: (request, response) ->
    term = request.term.toLowerCase()
    cached = @from_cache(term)
    return response cached if cached
    $.getJSON "/suggestions", request, (data) =>
      @cache[term] = data
      response @from_cache(term)

  from_cache: (term) ->
    result = false
    $.each @cache, (key, data) =>
      if term.indexOf(key) is 0 and data.length < @settings.from_db
        result = @filter_terms(data, term).slice(0, @settings.to_display)
    result

  filter_terms: (array, term) ->
      matcher = new RegExp($.ui.autocomplete.escapeRegex(term), "i")
      $.grep array, (value) =>
        source = value.label or value.value or value

        return true if matcher.test(source)

  extension_methods: ->
    _renderItem: (ul, item) ->
        item.label = item.label.replace(new RegExp("(" + $.ui.autocomplete.escapeRegex(@term) + ")", "gi"), "<strong>$1</strong>")
        $("<li></li>").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo ul
