
/**
 * View handleing service
 */
var viewService = function() {

    /** show with add / remove class **/
    this.shShow = function(hide_el, show_el, remove_class, add_class, fade_in, callback){
        $(hide_el).removeClass(remove_class).addClass(add_class, function(){});
        $(show_el).fadeIn(fade_in);
        if (callback != undefined) {
            callback();
        }
    };

    /** hide with add / remove class **/
    this.shHide = function(show_el, hide_el, add_class, remove_class, fade_out, callback){
        $(hide_el).fadeOut(fade_out);
        $(show_el).removeClass(remove_class).addClass(add_class);
        if (callback != undefined) {
            callback();
        }
    };

    /** show hide simple with fade **/
    this.shsShow = function(hide_el, show_el, fade_out, callback) {

        if (hide_el != undefined){
            $(hide_el).fadeOut(fade_out);
        }

        if (show_el != undefined) {
            $(show_el).fadeIn();
        }

        if (callback != undefined) {
            callback();
        }
    };

    this.shsHide = function(hide_el, show_el, fade_in, callback) {

        if (show_el != undefined) {
            $(show_el).fadeIn(fade_in);
        }

        if (hide_el != undefined) {
            $(hide_el).hide();
        }

        if (callback != undefined) {
            callback();
        }
    };

};