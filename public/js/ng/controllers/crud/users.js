var usersExtraCrudDirective = function(api) {
    return {
        restrict: 'A',
        compile: function(el, atts) {
            return function(s, el, atts) {

                s.setTime = function(time_in, time_out){
                    a.forEach(rs.days, function(week_day){
                        s.crud_mod[week_day+'_in']  = time_in;
                        s.crud_mod[week_day+'_out'] = time_out;
                    });
                };

                s.allDays = function(value) {
                    a.forEach(rs.days, function(week_day){
                        s.crud_mod[week_day] = value;
                    });
                };

            }
        }
    }
};