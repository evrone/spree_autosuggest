//= require store/spree_core
$.ui.autocomplete.prototype._renderItem = function( ul, item) {
    // var re = new RegExp("^" + this.term) ;
    // var t = item.label.replace(re,"<strong>" + this.term + "</strong>");
    item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(this.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
    return $("<li></li>")
        .data( "item.autocomplete", item )
        .append( "<a>" + item.label + "</a>" )
        .appendTo(ul);
};
(function($){
  $(document).ready(function(){

      var suggestions_cache = {}, lastXhr;

      $("#keywords").autocomplete(
      {
        source: function( request, response ) {
                  var term = request.term;
                  if ( term in suggestions_cache ) {
                    response( suggestions_cache[ term ] );
                    return;
                }
                lastXhr = $.getJSON( "/suggestions", request, function( data, status, xhr ) {
                  suggestions_cache[ term ] = data;
                  if ( xhr === lastXhr ) {
                    response( data );
                  }
                })
        },
        minLength: 2
      });



  });
})(jQuery);
