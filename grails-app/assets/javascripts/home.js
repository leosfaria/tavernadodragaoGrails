/**
 * Created by Leonardo on 22/03/2015.
 */

$(function() {
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
        minLength: 3//,
        //select: function (event, ui) {
        //    console.log(ui.item ?
        //    "Selected: " + ui.item.label :
        //    "Nothing selected, input was " + this.value);
        //}
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        var html = $("<li class='search'></li>")
            .data("item.autocomplete", item)
            .append("<img src='" + item.img + "'/>")
            .append("<a>" + item.label + "</a>");

        if(item.friendAdd !== undefined) {
            html.append("<a href='" + item.friendAdd + "' class='btn btn-primary btn-xs'>Add Friend</a>")
        } else if (item.friendAccept !== undefined) {
            html.append("<a href='" + item.friendAccept + "' class='btn btn-success btn-xs'>Accept</a>")
            //html.append("<a href='" + item.friendDecline + "'>Decline</a>")
        } else if (item.friendRequestSent !== undefined) {
            html.append("<label>Request Sent</label>")
        }

        return html.appendTo(ul);
    };
});