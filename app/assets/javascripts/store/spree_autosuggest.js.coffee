//= require store/spree_core
$.ui.autocomplete::_renderItem = (ul, item) ->
  item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(@term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>")
  $("<li></li>").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo ul

$ ->
  cache = {}
  $("#keywords").autocomplete
    source: (request, response) ->
      term = request.term.toLowerCase()

      foundInCache = false
      $.each cache, (key, data) ->
        if term.indexOf(key) is 0 and data.length > 0 and data.length < 15
          response $.ui.autocomplete.filter(data, term).slice(0,5)
          foundInCache = true
          return

      return if foundInCache

      $.getJSON "/suggestions", request, (data) ->
        cache[term] = data
        response data.slice(0, 5)

    minLength: 1
