function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#imagePreview').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

$(function() {
    var image = $("#imageFile");
    var menuChar = $('#menuCharacters');

    $('input[type=file]').bootstrapFileInput();

    if(image !== undefined) {
        $('#imagePreview').hide();

        image.change(function(){
            $('#imagePreview').show();
            readURL(this); //imagePreview
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