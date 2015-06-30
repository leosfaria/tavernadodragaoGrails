function readURL(input) {
    if (input.files && input.files.length > 0) {
        for(var i = 0; i < input.files.length; i++) {
            var reader = new FileReader();

            reader.onload = (function(i) {
                return function (e) {
                    var elem = $('#imagePreview').clone();

                    elem.attr('id', 'imagePreview-' + i).find('img').attr('src', e.target.result);
                    elem.append('<span>' + input.files[i].name + '</span>');
                    $('#imagePreview').parent().append(elem);

                    //$('#imagePreview-' + i).show();
                    $('#imagePreview-' + i).css('display', 'inline-block');
                }
            })(i);

            reader.readAsDataURL(input.files[i]);
        }
    }
}

$(function() {
    var image = $("#imageFile");
    var menuChar = $('#menuCharacters');

    $('#imageAddBtn').click(function (e) {
        $('#imageFile').click();
    });

    if(image !== undefined) {
        $('#imagePreview').hide();

        image.change(function(){
            $('div[id^=imagePreview-]').remove();
            readURL(this); //imageFile
        });
    }

    if(menuChar !== undefined) {
        menuChar.hover(function() {
            $(this).addClass("open");
        }, function() {
            $(this).removeClass("open");
        });
    }
});