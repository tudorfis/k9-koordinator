/**
 * foundation run
 */
var foundationRun = function(){
    $(document).foundation({
        abide: {
            patterns: {
                number: /[0-9]/,
                time_pattern: /[0-9]{2}\:[0-9]{2}(\:[0-9]{2})?/
            }
        }
    });
};