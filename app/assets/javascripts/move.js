$(document).ready(function(){
  $(".spot").one('click', function(){
    var value = $(this).data('moves')
    $( "#" + value ).append("x");
      $.ajax({
        method: 'put',
        url: '/game/update',
        data: { "move": value,
                "player": "x" },
        success: function(res) {
          $.ajax({
            method: 'put',
            url: '/game/update',
            data: { "move": value,
                    "player": "o" },
            success: function(res) {
              $( "#" + res[res.length - 31] ).parent().addClass("no-click");
              $( "#" + res[res.length - 31] ).append("o");
            }
          });
        }
      });
    });
  });
