function readURL(input) {
    console.log(input.files[0].type.indexOf('image') >= 0);

    if (input.files && input.files.length > 0) {
        for(var i = 0; i < input.files.length; i++) {
            var reader = new FileReader();

            reader.onload = (function(i) {
                return function (e) {
                    var elem = $('#imagePreview').clone();

                    elem.attr('id', 'imagePreview-' + i);
                    elem.find('img').attr('src', e.target.result);
                    elem.find('a').attr('href', e.target.result).attr('title', input.files[i].name).addClass('fancybox-thumb');
                    $('#imagePreview').parent().parent().append(elem);

                    $('#imagePreview-' + i).css('display', 'inline-block');
                }
            })(i);

            reader.readAsDataURL(input.files[i]);
        }

        $(".fancybox-thumb").fancybox({
            prevEffect	: 'none',
            nextEffect	: 'none',
            helpers	: {
                title	: {
                    type: 'outside'
                },
                thumbs	: {
                    width	: 50,
                    height	: 50
                }
            }
        });
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