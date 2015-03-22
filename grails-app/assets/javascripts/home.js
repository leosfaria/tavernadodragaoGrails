/**
 * Created by Leonardo on 22/03/2015.
 */

$(function() {
    $('#menuCharacters').on('mouseenter', function() {
        console.log('oi');
        $(this).addClass("open");
    });

    $('#menuCharacters').on('mouseout', function() {
        console.log('tchau');
        $(this).removeClass("open");
    });
});