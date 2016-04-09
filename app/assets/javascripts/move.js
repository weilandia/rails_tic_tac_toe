$(document).ready(function(){
  $(".spot").one('click', function(){
    var value = $(this).data('moves')
    $( "#" + value ).append("x");
      $.ajax({
        method: 'put',
        url: '/games/' + id,
        data: { "move": value },
        success: function(res) {
          }
    });
  });
});
