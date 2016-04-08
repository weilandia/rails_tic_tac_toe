$(document).ready(function(){

  $(".spot").one('click', function(){
    var value = $(this).data('coordinates')
    $( "#" + value ).append("x");
      $.ajax({
        method: 'put',
        url: '/game',
        data: { "coordinate": value },
        success: function(res) {
          }
    });
  });
});
