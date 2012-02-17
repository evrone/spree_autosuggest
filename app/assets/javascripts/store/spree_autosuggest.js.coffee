//= require store/spree_core
$.ui.autocomplete::_renderItem = (ul, item) ->
  item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(@term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>")
  $("<li></li>").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo ul

$ ->
  $(document).ready ->
    suggestions_cache = {}
    lastXhr = null
    $("#keywords").autocomplete
      source: (request, response) ->
        term = request.term
        if term of suggestions_cache
          response suggestions_cache[term]
          return
        lastXhr = $.getJSON("/suggestions", request, (data, status, xhr) ->
          suggestions_cache[term] = data
          response data if xhr is lastXhr
        )

      minLength: 2
