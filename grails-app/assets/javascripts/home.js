/**
 * Created by Leonardo on 22/03/2015.
 */

$(function() {
    $('#menuCharacters').hover(function() {
        $(this).addClass("open");
    }, function() {
        $(this).removeClass("open");
    });

    $( "#search" ).autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "/tavernadodragaoGrails/search/search",
                dataType: "json",
                data: {
                    q: request.term
                },
                success: function (data) {
                    response(data);
                }
            });
        },
        minLength: 3,
        select: function (event, ui) {
            console.log(ui.item ?
            "Selected: " + ui.item.label :
            "Nothing selected, input was " + this.value);
        }
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        var html = $("<li class='search'></li>")
            .data("item.autocomplete", item)
            .append("<img src='" + item.img + "'/>")
            .append("<a>" + item.label + "</a>")

        if(item.friend !== undefined) {
            html.append("<a href='" + item.friend + "'>Add Friend</a>")
        }

        return html.appendTo(ul);
    };
});