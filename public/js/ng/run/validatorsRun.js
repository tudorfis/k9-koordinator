/**
 * Validators run
 */
var validatorsRun = function() {

    rs.checkDatesExists = function(s, table, mod, d_in, d_out, post) {
        if (!post.break_submit) {
            a.forEach(rs.pet[table], function (item) {
                if (item.in_out == 'in') {
                    var date_in = new Date(item[d_in]).getTime(),
                        date_out = new Date(item[d_out]).getTime(),
                        date_in_input = new Date(s[mod][d_in]).getTime(),
                        date_out_input = new Date(s[mod][d_out]).getTime();
                    if ((date_in_input >= date_in && date_in_input <= date_out) ||
                        (date_out_input >= date_in && date_out_input <= date_out)) {
                        rs.alertMsg("Pet already has reservation in this period, please check and modify if necesary");
                        post.break_submit = 1;
                        return false;
                    }
                }
            });
        }
    };

    rs.checkDatesBigger = function(s, mod, d_in, d_out, post) {
        var date_in = new Date(s[mod][d_in]).getTime(),
            date_out = new Date(s[mod][d_out]).getTime();
        if (date_out < date_in) {
            rs.alertMsg("Please select date out to be bigger or equal than date in");
            post.break_submit = 1;
            return false;
        }
    };

    rs.checkDatesToday = function(s, mod, d_in, post) {
        if (!post.break_submit) {
            var date_in = new Date(s[mod][d_in]).getTime(),
                date_now = new Date(rs.getCurrentDate()).getTime();
            if (date_in < date_now) {
                rs.alertMsg("Cannot add past dates for reservations!");
                post.break_submit = 1;
                return false;
            }
        }
    };

    rs.checkDatesExtra = function(s, mod, d_in, d_out, checked_date, post, message) {
        if (!post.break_submit) {
            var date_in = new Date(s[mod][d_in]).getTime(),
                date_out = new Date(s[mod][d_out]).getTime(),
                checked_date_input = new Date(checked_date).getTime();
            if (checked_date_input < date_in || checked_date_input > date_out) {
                rs.alertMsg(message);
                post.break_submit = 1;
                return false;
            }
        }
    };

    rs.checkCheckInOutTime = function(s, mod, t_in, t_out, post) {
        if (!post.break_submit) {
            var time_in_t = rs.getTimeTimestamp(s[mod][t_in]),
                time_out_t = rs.getTimeTimestamp(s[mod][t_out]),
                default_time_in_t = rs.getTimeTimestamp(rs.boarding_settings.check_in_time),
                default_time_out_t = rs.getTimeTimestamp(rs.boarding_settings.check_out_time);

            if ((s[mod][t_in] && s[mod][t_out]) && time_in_t > time_out_t) {
                rs.alertMsg('Check out time cannot be earlier thant check in time !');
                post.break_submit = 1;
            } else if (s[mod][t_in] && time_in_t < default_time_in_t) {
                rs.alertMsg('The time of check in is much earlier than the specified check in time in "Boarding settings & charges"');
                post.break_submit = 1;
            } else if (s[mod][t_in] && time_in_t > default_time_out_t) {
                rs.alertMsg('The time in is later than the specified check out closing time in "Boarding settings & charges"');
                post.break_submit = 1;
            } else if (s[mod][t_out] && time_out_t < default_time_in_t) {
                rs.alertMsg('The time of check out is much earlier than the specified check in time in "Boarding settings & charges"');
                post.break_submit = 1;
            } else if (s[mod][t_out] && time_out_t > default_time_out_t) {
                rs.alertMsg('The time of check out is later than the specified check out closing time in "Boarding settings & charges"');
                post.break_submit = 1;
            }
        }
    };

    rs.checkDatesWeekendHolidaysSeason = function(s, mod, d_in, d_out, post) {
        if (!post.break_submit) {
            var date_in = new Date(s[mod][d_in]),
                date_out = new Date(s[mod][d_out]),
                date_in_t = date_in.getTime(),
                date_out_t = date_out.getTime(),
                nr_days = 0;

            if ((date_out_t - date_in_t) == 0) {
                nr_days = 1
            } else {
                nr_days = (date_out_t - date_in_t) / 86400;
            }
            for (var i = 0; i <= nr_days; i++) {
                var date_c = date_in;
                date_c.setDate(date_in.getDate()+i);
                var date_c_name = date_c.toString().substring(0,3).toLowerCase();

                /** saturdays **/
                if (date_c_name == 'sat' && !rs.boarding_settings.available_for_saturdays) {
                    rs.alertMsg("Reservations are not available on saturdays !");
                    post.break_submit = 1;
                    return false;

                    /** sundays **/
                } else if (date_c_name == 'sun' && !rs.boarding_settings.available_for_sundays) {
                    rs.alertMsg("Reservations are not available on sundays !");
                    post.break_submit = 1;
                    return false;

                }
                /** @TODO: holidays **/
                //else if (!rs.boarding_settings.available_for_holidays) {
                //    a.forEach(rs.holiday, function(holiday_item){
                //        if (holiday_item.date.toString().substr(5,10) == rs.getCurrentDate(date_c).toString().substr(5, 10)) {
                //            rs.alertMsg("Reservations on holidays are not available, its '"+ holiday_item.v +"'");
                //            post.break_submit = 1;
                //            return false;
                //        }
                //    });
                //}

                /** @TODO: season **/
                //if (!post.break_submit) {
                //    a.forEach(rs.season, function(season_item){
                //        if (season_item.in_use) {
                //            var start_date_s = rs.getYear().toString() + season_item.start_date.toString().substr(4, 10),
                //                end_date_s = rs.getYear().toString() + season_item.end_date.toString().substr(4, 10),
                //                start_date = new Date(start_date_s),
                //                end_date = new Date(end_date_s),
                //                start_date_t = start_date.getTime(),
                //                end_date_t = end_date.getTime(),
                //                nr_days_season = 0;
                //
                //            /** do season dates **/
                //            if ((end_date_t - start_date_t) == 0) {
                //                nr_days_season = 1
                //            } else {
                //                nr_days_season = (end_date_t - start_date_t) / 86400;
                //            }
                //
                //            console.log(start_date);
                //            console.log(nr_days_season);
                //            console.log('##################');
                //
                //            for (var j = 0; j <= nr_days_season; j++) {
                //                var date_c_season = start_date;
                //                date_c_season.setDate(start_date.getDate()+j);
                //                var date_c_season_n = date_c_season.toString().substring(0,3).toLowerCase();
                //
                //                console.log(date_c_season);
                //                console.log(date_c_season_n);
                //                console.log('##################');
                //
                //                if (!season_item['is_'+date_c_season_n] && date_c_name == date_c_season_n) {
                //                    rs.alertMsg("Reservations are not available on '"+ date_c_season_n +"' in '"+ season_item.v +"'");
                //                    post.break_submit = 1;
                //                    nr_days_season = 0;
                //
                //                    console.log(date_c);
                //                    console.log(date_c_name);
                //                    console.log(date_c_season);
                //                    console.log(date_c_season_n);
                //                    console.log('##################');
                //
                //                    return false;
                //                }
                //            }
                //        }
                //    });
                //}
            }
        }
    }

};