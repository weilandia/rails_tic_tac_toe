$(document).ready(function(){
  $(".spot").one('click', function(){
    var user_move = $(this).data('moves')
    $( "#" + user_move ).append("x");
    $( "#" + user_move ).parent().addClass("no-click");
      $.ajax({
        method: 'put',
        url: '/game/update',
        data: { "move": user_move,
                "player": "x" },
        success: function(res) {
          $.ajax({
            method: 'put',
            url: '/game/update',
            data: { "player": "o" },
            success: function(res) {
              $( "#" + res[res.length - 31] ).parent().addClass("no-click");
              $( "#" + res[res.length - 31] ).append("o");
            }
          });
        }
      });
    });
  });
