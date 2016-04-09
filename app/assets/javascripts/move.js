$(document).ready(function(){
  $(".spot").one('click', function(){
    var value = $(this).data('moves')
    $( "#" + value ).append("x");
      $.ajax({
        method: 'put',
        url: '/games/' + id,
        data: { "move": value },
        success: function(res) {
          $.ajax({
            method: 'get',
            url: '/games/' + id + "/moves",
            success: function(res) {
              $( "#" + res[res.length - 1] ).unbind("click");
              $( "#" + res[res.length - 1] ).append("o");
            }
          });
        }
    });
  });
});
