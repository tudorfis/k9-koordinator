/**
 * Scroll up run
 */
var scrollUpRun = function() {
    $(document).ready(function(){
        var mainContent = document.getElementById('mainContent'),
            body = $('body');
        mainContent.style.height = body.innerHeight()+'px';
        $('#pet-info').css('height', (body.innerHeight()-80)+'px');
        $('.pet-rsv').css('height', (body.innerHeight()-150)+'px');
        $('#leftMenu').css('height', (body.innerHeight()-80)+'px');
        mainContent.addEventListener('scroll', function(){
            if ($(this).scrollTop() > 100) {
                $('.scrollup').fadeIn();
            } else {
                $('.scrollup').fadeOut();
            }
        }, false);
        $('.scrollup').click(function(){
            mainContent.scrollTop = 0;
            return false;
        });
    });
};