function readURL(input) {
    if (input.files && input.files.length > 0) {
        for(var i = 0; i < input.files.length; i++) {
            var reader = new FileReader();

            reader.onload = (function(i) {
                return function (e) {
                    var elem = $('#imagePreview').clone();

                    elem.attr('id', 'imagePreview-' + i).attr('src', e.target.result).appendTo('.previewImages');

                    $('#imagePreview-' + i).show();
                }
            })(i);

            reader.readAsDataURL(input.files[i]);
        }
    }
}

$(function() {
    var image = $("#imageFile");
    var menuChar = $('#menuCharacters');

    $('input[type=file]').bootstrapFileInput();

    if(image !== undefined) {
        $('#imagePreview').hide();

        image.change(function(){
            $('img[id^=imagePreview-]').remove();
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