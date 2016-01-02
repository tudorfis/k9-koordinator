/**
 * Views run
 */
var viewsRun = function($timeout) {
    rs.hs = function(h, s) {
        $(h).hide();
        $(s).show();
    };
    rs.sh = function(s, h) {
        $(s).show();
        $(h).hide();
    };
    rs.revealModal = function(modal) {
        $(modal).foundation('reveal', 'open');
    };
    rs.closeModal = function(modal) {
        $(modal).foundation('reveal', 'close');
    };
    rs.closeCurrentModal = function() {
        $('.reveal-modal').filter(":visible").foundation('reveal','close');
    };
    rs.hideContentShowAl = function() {
        $('#ajaxLoaderHuge').show();
        $('#mainContent').css({'opacity': '0.6'});
    };
    rs.hideAlShowContent = function() {
        $('#ajaxLoaderHuge').hide();
        $('#mainContent').css({'opacity': '1'});
    };
    rs.fadeInElement = function(el_selector, speed) {
        speed = (speed || 'medium');
        $(el_selector).fadeIn(speed);
    };
    rs.fadeOutElement = function(el_selector, speed) {
        speed = (speed || 'medium');
        $(el_selector).fadeOut(speed);
    };
    rs.showElement = function(el_selector) {
        $(el_selector).show();
    };
    rs.hideElement = function(el_selector) {
        $(el_selector).hide();
    };
    rs.checkCpClient = function() {
        if (rs.isEmpty(rs.client)) {
            var el = $('#cpModal a[href="#panel_client_1"]');
            if (!el.parent('dd').hasClass('active')) {
                el.trigger('click');
            }
        }
    };
    rs.checkCpPet = function() {
        if (rs.isEmpty(rs.pet)) {
            var el = $('#cpModal a[href="#panel_pet_1"]');
            if (!el.parent('dd').hasClass('active')) {
                el.trigger('click');
            }
        }
    };
    rs.alertMsg = function(msg) {
        if (msg) {
            rs.alert_message = msg;
            $timeout(function(){
                $('.alertMsg').show();
            }, 100);
            $timeout(function(){
                $('.alertMsg').hide();
            }, 3000)
        }
    };
    rs.confirmMsg = function(msg, func) {
        if (msg) {
            rs.confirm_message = msg;
            rs.confirmFunc = func;
            $timeout(function(){
                $('.confirmMsg').show();
            }, 100);
            $timeout(function(){
                $('.confirmMsg').hide();
            }, 3000)
        }
    };

};