/**
 * Reports
 * @param pdf
 */
var reportsRun = function(pdf) {

    /**
     * Client membership
     * @param s
     */
    rs.clientMembershipReport = function(s) {

        var language_text = rs.l.l_text('en');
        rs.l.setLanguage('en');

        var docDefinition = {
            content: [
                {
                    columns: [
                        {
                            width: '50%',
                            text: [
                                {
                                    text: "\n" + rs.client.first_name + ', ' + rs.client.last_name + "\n\n",
                                    style: 'topTitle'
                                },
                                (s.client_membership_mod.valability ?
                                {
                                    text: rs.l.l('valability')+': ' + s.client_membership_mod.valability + "\n\n",
                                    style: 'subTitle2'
                                } : {
                                    text: rs.l.l('valability')+': - '+ rs.l.l('unlimited') +' -' + "\n\n",
                                    style: 'subTitle2'
                                } ),
                                {
                                    text: (rs.client.email ? rs.l.l('email')+': ' + rs.client.email : '') + "\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: (rs.client.preffered_phone ? rs.l.l('phone')+': ' + rs.client.preffered_phone : '') + "\n\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: (s.client_membership_mod.membership ?
                                    rs.l.l('membership')+'' + "\n" + s.client_membership_mod.membership : '') + "\n",
                                    style: 'subText'
                                }
                            ]
                        },
                        {
                            width: '50%',
                            text: [
                                {
                                    text: "\n\n\n" + (s.client_membership_mod.add_pet_name ? rs.l.l('pet_name')+': ' + rs.pet.pet_name : ''),
                                    style: 'subTitle2'
                                }
                            ]
                        }
                    ]
                },
                {
                    text: "\n\n"
                },
                {
                    alignment: 'justify',
                    columns: [
                        (s.client_membership_mod.print_photo_client ?
                        {
                            image: pdf.client_image,
                            style: {width: '25%', height: 'auto', margin: [10, 10, 10, 10]}
                        } : {text: ''}),
                        (s.client_membership_mod.print_photo_pet ?
                        {
                            image: pdf.pet_image,
                            style: {width: '25%', height: 'auto'}
                        } : {text: ''})
                    ]
                },
                {
                    text: "\n\n\n\n\n\n"
                },
                {
                    image: $('#clients-membership').find('#barcode').attr('src'),
                    style: 'barcodeImage'
                }
            ],
            styles: a.extend(pdf.styles, {
                barcodeImage: {width: 400, height: 70, margin: [0, 0, 0, 30]},
                cpImage: {width: 50, height: 50, margin: [0, 10, 0, 10]}
            })
        };

        docDefinition.content.unshift(pdf.contactInfoHeader());
        var report_name = 'client_membership_' + rs.client.first_name + '_' + rs.client.last_name + '_' + rs.getCDT() + '.pdf';
        pdf.options(s.client_membership_mod.print_type, docDefinition, report_name);

    };

    /**
     * Deposit report
     * @param d_mod
     */
    rs.depositReport = function(d_mod) {

        var language_text = rs.l.l_text(d_mod.language);
        rs.l.setLanguage(d_mod.language);

        var docDefinition = {
            content: [
                {image: pdf.hr_image},
                {text: "\n\n"},
                {
                    text: (rs.payment_types[d_mod.payment_type_id] ? rs.l.l('deposit_report') : rs.l.l('paid_from_deposit_report')),
                    style: 'topTitle'
                },
                {text: "\n\n"},
                {
                    columns: [
                        {
                            width: '50%',
                            text: [
                                {
                                    text: rs.l.l('client_information') +": \n\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.client.first_name + ', ' + rs.client.last_name+"\n",
                                    style: 'topTitle2'
                                },
                                {
                                    text: rs.l.l('email')+': ' + (rs.client.email || '-')+"\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: rs.l.l('phone')+': ' + (rs.client.preffered_phone || '-')+"\n",
                                    style: 'subTitle'
                                },
                                (rs.access.checkRewards() ?
                                    {
                                        text: "\n"+ (rs.clients[rs.client.id].reward_points || 0) +" "+  rs.l.l('reward_points_to_date') +"\n",
                                        style: 'subTitle'
                                    } : {text:"\t"}
                                ),
                                {text: "\n\n\n"},
                                {
                                    text: rs.l.l('total').toUpperCase() +":   "+ pF(d_mod.payment_amount).toFixed(2) +" $\t\n\n",
                                    style: 'topTitle2'
                                }
                            ]
                        },
                        {
                            width: '50%',
                            text: [
                                {
                                    text: rs.l.l('billing_information')+": \n\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.l.l('language')+":         "+language_text+"\n\n",
                                    style: 'subTitle'

                                },
                                {
                                    text: rs.l.l('payment_type')+":     "+ (rs.payment_types[d_mod.payment_type_id] ? rs.payment_types[d_mod.payment_type_id].v : '-') +"\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: (d_mod.date_created ? rs.l.l('date_created')+":     "+ d_mod.date_created +"\n" : "\n"),
                                    style: 'subTitle'
                                },
                                (d_mod.is_a_tip ?
                                    {
                                        text: "\n"+rs.l.l('is_tip')+" ?                 "+ (d_mod.is_a_tip == 1 ? 'Yes' : 'No') +"\n",
                                        style: 'subTitle'

                                    } : {text: "\n"}
                                    ),
                                (d_mod.is_a_tip ?
                                    {
                                        text: rs.l.l('tipped_user')+":         "+(rs.users[d_mod.tip_user_id] ? rs.users[d_mod.tip_user_id].v : '-')+"\n\n",
                                        style: 'subTitle'

                                    } : {text: "\n\n"}
                                )
                            ]
                        }
                    ]
                },
                {text: "\n\n"}
            ],
            styles: pdf.styles
        };
        docDefinition.content.unshift(pdf.contactInfoHeader());
        var report_name = 'deposit_'+ rs.client.first_name +'_'+ rs.client.last_name +'_'+ rs.getCDT() +'.pdf';
        pdf.options(d_mod.print_type, docDefinition, report_name);

    };


    /**
     * POS Report
     * @param language
     * @param print_type
     * @param is_walk_in_sale
     * @param required
     * @param paid
     * @param change
     * @param unpaid
     * @param o
     * @param oo
     */
    rs.posReport = function(language, print_type, is_walk_in_sale, required, paid, change, unpaid, o, oo) {

        var is_refund = (o.payment_status_id == 3);

        var language_text = rs.l.l_text(language);
        rs.l.setLanguage(language);

        var i_array = [];
        i_array.push([
            {text: rs.l.l('name'),    style: 'tableHeader'},
            {text: rs.l.l('qty'),     style: 'tableHeader'},
            {text: rs.l.l('price'),   style: 'tableHeader'},
            {text: rs.l.l('adaos'),   style: 'tableHeader'},
            {text: rs.l.l('disc'),    style: 'tableHeader'},
            {text: rs.l.l('coupon'),  style: 'tableHeader'},
            {text: rs.l.l('tax'),     style: 'tableHeader'},
            {text: rs.l.l('o_tax'),   style: 'tableHeader'},
            {text: rs.l.l('total'),   style: 'tableHeader'}
        ]);
        a.forEach(oo, function(rio){
            i_array.push([
                rio.product_name,
                pF(rio.add_qty).toFixed(0),
                rio.price +"$",
                "+"+ pF(rio.adaos).toFixed(2) +"$",
                "-"+ pF(rio.discount).toFixed(2) +"$",
                "-"+ pF(rio.coupon_total).toFixed(2) +"$",
                "+"+ pF(rio.tax_total).toFixed(2) +"$",
                "+"+ pF(rio.o_tax_total).toFixed(2) +"$",
                pF(rio.total).toFixed(2) +"$"
            ]);
        });

        var dd_client_information = null;
        if (is_walk_in_sale) {
            dd_client_information = [{
                text: "- "+ rs.l.l('walk_in_client') +" - \n\n",
                style: 'subTitle2'
            }]
        } else {
            dd_client_information = [
                {
                    text: rs.l.l('client_information') +": \n\n",
                    style: 'subTitle2'
                },
                {
                    text: rs.client.first_name + ', ' + rs.client.last_name+"\n",
                    style: 'topTitle2'
                },
                {
                    text: rs.l.l('email')+': ' + (rs.client.email || '-')+"\n",
                    style: 'subTitle'
                },
                {
                    text: rs.l.l('phone')+': ' + (rs.client.preffered_phone || '-')+"\n",
                    style: 'subTitle'
                },
                (rs.access.checkRewards() ?
                    {
                        text: "\n"+ (rs.clients[rs.client.id].reward_points || 0) +" "+  rs.l.l('reward_points_to_date') +"\n",
                        style: 'subTitle'
                    } : {text:"\t"}
                )
            ]
        }

        var dd_left_text = dd_client_information.concat([
            {text: "\n\n\n"},
            {
                text: rs.l.l('total').toUpperCase() +":   "+ pF(required).toFixed(2) +" $\t\n\n",
                style: 'topTitle2'
            },
            (!is_refund ?
                {
                    text: rs.l.l('paid')+":             "+ pF(paid).toFixed(2) +" $\t\n",
                    style: 'topTitle3'
                } : {text:"\n"}
            ),
            (!is_refund ?
                {
                    text: rs.l.l('change')+":       "+ pF(change).toFixed(2) +" $\t\n",
                    style: 'topTitle3'
                } : {text:"\n"}
            ),
            (!is_refund ?
                {
                    text: rs.l.l('unpaid')+":       "+ pF(unpaid).toFixed(2) +" $\t\n",
                    style: 'topTitle3'
                } : {text:"\n"}
            )
        ]);

        var docDefinition = {
            content: [
                {image: pdf.hr_image},
                {text: "\n\n"},
                {
                    text: (is_refund ? rs.l.l('refund_report') : rs.l.l('point_of_sale_report')),
                    style: 'topTitle'
                },
                {text: "\n\n"},
                {
                    columns: [
                        {
                            width: '50%',
                            text: dd_left_text
                        },
                        {
                            width: '50%',
                            text: [
                                {
                                    text: rs.l.l('billing_information')+": \n\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.l.l('language')+":         "+language_text+"\n",
                                    style: 'subTitle'

                                },
                                {
                                    text: rs.l.l('payment_type')+":     "+ (rs.payment_types[o.payment_type_id] ? rs.payment_types[o.payment_type_id].v : '-') +"\n",
                                    style: 'subTitle'
                                },
                                (!is_refund ?
                                    {
                                        text: (o.payment_status_id ? rs.l.l('payment_status')+":     "+ rs.payment_status[o.payment_status_id].v : "") +"\n\n",
                                        style: 'subTitle'
                                    } : {text:"\n"}
                                ),
                                {
                                    text: (o.date_created ? rs.l.l('date_created')+":     "+ o.date_created +"\n" : "\n"),
                                    style: 'subTitle'
                                },
                                {
                                    text: (o.date_modified ? rs.l.l('date_modified')+":     "+ o.date_modified +"\n" : "\n"),
                                    style: 'subTitle'
                                },
                                ((o.promotion_id && !is_refund) ?
                                    {
                                        text:  rs.l.l('rewards')+" \n\n " +
                                        rs.promotions[o.promotion_id].promotion_name + "\t\n" +
                                        rs.promotions[o.promotion_id].description + "\t\n\n" +
                                        rs.l.l('points_per_dollar')+":     " + rs.promotions[o.promotion_id].points + "\t\n" +
                                        rs.l.l('discount')+":               -" + pF(o.promotion_discount).toFixed(2) + " $\t\n",
                                        style: 'subTitle3'
                                    } : {text:''}
                                )
                            ]
                        }
                    ]
                },
                {text: "\n\n"},
                {   style: 'tableExample',
                    table: {
                        headerRows: 1,
                        widths: ['20%', '10%', '10%', '10%', '10%', '10%', '10%', '10%', '10%'],
                        body: i_array
                    },
                    layout: 'lightHorizontalLines'
                }
            ],
            styles: pdf.styles
        };
        docDefinition.content.unshift(pdf.contactInfoHeader());
        var report_name = (is_walk_in_sale ? 'billing_walk_in_sale_'+ rs.getCDT() +'.pdf' :
                'billing_'+ rs.client.first_name +'_'+ rs.client.last_name +'_'+ rs.getCDT() +'.pdf');

        pdf.options(print_type, docDefinition, report_name);

    };

    /**
     *
     * @param o
     * @param rb
     * @param id
     * @param tbl
     * @param without_print
     * @returns {{total: number}}
     */
    rs.rsvReport = function(o, rb, id, tbl, without_print) {

        var language_text = rs.l.l_text(o.language);
        rs.l.setLanguage(o.language);

        var client = (rs.clients[rb.client_id] || {}),
            pet = (rs.pets[rb.pet_id] || {});

        var client_name = (client.first_name ? client.first_name : '-')+(client.last_name ? client.last_name : '-'),
            client_email = (client.email || '-none-'),
            client_phone = (client.contact_phone || '-none'),
            pet_name = (pet.pet_name || '-'),
            pet_type = rs.pet_type[pet.pet_type_id].v,
            pet_breed = rs.pet_breed[pet.pet_breed_id].v;

        var date_in = rb.date_in,
            time_in = rb.time_in,
            date_out = (rb.date_checkout || rb.date_out),
            time_out = (rb.time_checkout || rb.time_out),
            date_in_t = new Date(date_in).getTime()/1000,
            date_out_t = new Date(date_out).getTime()/1000,
            time_in_t = rs.getTimeTimestamp(time_in),
            time_out_t = rs.getTimeTimestamp(time_out),
            nr_days = null,
            is_halfday = null,
            charge_obj = {},
            charge_v = '',
            charge_full_day = null,
            charge_half_day = null,
            subtotal = 0,
            total = 0;

        if (date_out == '0000-00-00') {
            date_out = rb.date_out;
            date_out_t = new Date(date_out).getTime()/1000;
        }
        if (time_out == '00:00:00') {
            time_out = rb.time_out;
            time_out_t = rs.getTimeTimestamp(time_out);
        }

        if ((date_out_t - date_in_t) == 0) {
            nr_days = 1
        } else {
            nr_days = ((date_out_t - date_in_t) / 86400) + 1;
        }

        var charge_type = {},
            c_type = '',
            c_v = '',
            c_fullday = 0,
            c_halfday = 0;

        var type_of_report = '';


        /** BOARDING **/
        if (tbl == 'r_boarding') {

            type_of_report = rs.l.l('boarding_report');
            var stay_reason = (rs.stay_reasons[rb.stay_reason_id] ? rs.stay_reasons[rb.stay_reason_id].v : '-'),
                luggage = (rb.luggage || '-'),
                is_handle_carefully = (rb.is_handle_carefully ? 'Yes' : 'No'),
                is_extra_pet = (rb.is_extra_pet ? 'Yes' : 'No');

            if (rb.charge_type == 'charge_by_petsize') {
                charge_type = rs.boarding_petsizes[rb.charge_type_id];
                c_type = rs.l.l('charge_by_petsize');
            } else if (rb.charge_type == 'charge_by_runtype') {
                charge_type = rs.boarding_runtypes[rb.charge_type_id];
                c_type = rs.l.l('charge_by_runtype');
            }

            c_v = charge_type.v;
            c_fullday = charge_type.full_day;
            c_halfday = charge_type.half_day;

            var half_day_from_t = rs.getTimeTimestamp(rs.boarding_settings.half_day_from),
                half_day_to_t = rs.getTimeTimestamp(rs.boarding_settings.half_day_to),
                full_day_from_t = rs.getTimeTimestamp(rs.boarding_settings.full_day_from),
                full_day_to_t = rs.getTimeTimestamp(rs.boarding_settings.full_day_to);

            if (rb.is_halfday == 2) {
                if ((half_day_from_t <= time_in_t && time_in_t <= half_day_to_t) &&
                    (half_day_from_t <= time_out_t && time_in_t <= half_day_to_t)) {
                    is_halfday = 1;
                    total = c_halfday * nr_days;
                } else {
                    is_halfday = 0;
                    total = c_fullday * nr_days;
                }
            } else if (rb.is_halfday == 1) {
                is_halfday = 1;
                total = c_halfday * nr_days;
            } else if (rb.is_halfday == 0) {
                is_halfday = 0;
                total = c_fullday * nr_days;
            }

        /** DAYCARE **/
        } else if (tbl == 'r_daycare') {

            type_of_report = rs.l.l('daycare_report');
            charge_type = (rs.daycare_groups[rb.daycare_group_id] || {});
            c_v = charge_type.v;
            c_fullday = charge_type.full_day;
            c_halfday = charge_type.half_day;

            if (rb.is_halfday == 1) {
                is_halfday = 1;
                total = c_halfday * nr_days;
            } else if (rb.is_halfday == 0) {
                is_halfday = 0;
                total = c_fullday * nr_days;
            }

        /** GROOMS **/
        } else if (tbl == 'r_grooms') {

            type_of_report = rs.l.l('grooms_report');
            var groomer_v = rs.groomers[rb.groomer_id].v,
                grooming_rate_v = rs.grooming_rates[rb.grooming_rate_id].v,
                grooming_rate_multiplier = rs.grooming_rates[rb.grooming_rate_id].multiplier,
                is_hcp_v = (rb.is_hcp ? 'Yes' : 'No'),
                base_type_v = '',
                pet_size_id = rs.pets[rb.pet_id].pet_size_id,
                pet_size_v = rs.pet_size[rs.pets[rb.pet_id].pet_size_id].v;
            a.forEach(rs.base_type_filter, function(item){
                if (item.v == rb.base_type_id) {
                    base_type_v = item.n;
                }
            });
            var r_gs_table = [];
            r_gs_table.push([
                {text: rs.l.l('service'),               style: 'tableHeader'},
                {text: rs.l.l('price'),                 style: 'tableHeader'},
                {text: rs.l.l('is_handle_carefully'),   style: 'tableHeader'},
                {text: rs.l.l('multiplier'),            style: 'tableHeader'},
                {text: rs.l.l('nr_days'),               style: 'tableHeader'},
                {text: rs.l.l('total'),                 style: 'tableHeader'}
            ]);
            a.forEach(rb.gs_array, function(gs_id){
               var g_s = rs.grooming_services[gs_id],
                   g_service = g_s.v,
                   g_price = g_s["v_"+pet_size_id],
                   g_hcp = g_s.hcp,
                   g_multiplier = grooming_rate_multiplier,
                   g_total = 0;

                g_total = ((pF(g_price) * pF(g_multiplier)) + (rb.is_hcp ? pF(g_hcp) : 0)) * pF(nr_days);
                total += g_total;

                r_gs_table.push([
                    g_service,
                    "$"+ pF(g_price).toFixed(2),
                    (rb.is_hcp ? "+ $"+ pF(g_hcp).toFixed(2) : "-"),
                    (rb.multiplier ? "x"+ pF(g_multiplier).toFixed(2) : "-"),
                    "x "+nr_days.toString(),
                    pF(g_total).toFixed(2) + "$"
                ]);
            });

        /** TRAINING **/
        } else if (tbl == 'r_training') {

            type_of_report = rs.l.l('training_report');
            var trainer_v = rs.trainers[rb.t_id].v,
                tg_obj = rs.training_groups[rb.tg_id],
                tg_v = tg_obj.v,
                tg_limit = tg_obj.limit,
                tg_price = tg_obj.price,
                tg_rank = tg_obj.rank,
                tg_instructions = tg_obj.instructions,
                ts_obj = rs.training_schedule[rb.ts_id],
                ts_duration = ts_obj.time_duration;

            total = pF(tg_price) * nr_days;

            var r_t_table = [];
            r_t_table.push([
                {text: rs.l.l('name'),          style: 'tableHeader'},
                {text: rs.l.l('description'),   style: 'tableHeader'},
                {text: rs.l.l('price'),         style: 'tableHeader'},
                {text: rs.l.l('nr_days'),       style: 'tableHeader'},
                {text: rs.l.l('total'),         style: 'tableHeader'}
            ]);
            a.forEach(rs.training_options, function(to) {
                if (to.tg_id == rb.tg_id) {
                    var t_name = to.v,
                        t_description = to.description,
                        t_price = to.price,
                        t_total = 0;

                    t_total = pF(t_price) * pF(nr_days);
                    total += t_total
                    r_t_table.push([
                        t_name,
                        t_description,
                        "$" + pF(t_price).toFixed(2),
                        "x "+pF(nr_days).toFixed(0),
                        "$"+pF(t_total).toFixed(2)
                    ]);
                }
            });
        };

        subtotal = total;

        if (tbl == 'r_boarding' || tbl == 'r_daycare') {

            /** schedule services **/
            var is_r_ss = 0,
                r_ss_table = [],
                r_ss_total = 0;
            if (rs.ma(rb.r_ss).length > 0) {
                is_r_ss = 1;
                r_ss_table.push([
                    {text: rs.l.l('date'),                style: 'tableHeader'},
                    {text: rs.l.l('qty'),                 style: 'tableHeader'},
                    {text: rs.l.l('service'),             style: 'tableHeader'},
                    {text: rs.l.l('instructions'),        style: 'tableHeader'},
                    {text: rs.l.l('price'),               style: 'tableHeader'},
                    {text: rs.l.l('exclude_on_checkin'),  style: 'tableHeader'},
                    {text: rs.l.l('exclude_on_checkout'), style: 'tableHeader'},
                    {text: rs.l.l('total'),               style: 'tableHeader'},
                ]);
                a.forEach(rb.r_ss, function(r_ss){
                    var r_ss_item_total = 0;
                    if (r_ss.ss_exclude_checkin && r_ss.ss_exclude_checkout && (nr_days > 2)) {
                        if (r_ss.ss_everyday) {
                            r_ss_item_total += ((nr_days - 2) * r_ss.ss_times * r_ss.ss_price);
                        } else {
                            r_ss_item_total += r_ss.ss_times * r_ss.ss_price;
                        }
                    } else if ((r_ss.ss_exclude_checkin || r_ss.ss_exclude_checkout) && nr_days != 1) {
                        if (r_ss.ss_everyday) {
                            r_ss_item_total += ((nr_days - 1) * r_ss.ss_times * r_ss.ss_price);
                        } else {
                            r_ss_item_total += r_ss.ss_times * r_ss.ss_price;
                        }
                    } else {
                        if (r_ss.ss_everyday) {
                            r_ss_item_total += (nr_days * r_ss.ss_times * r_ss.ss_price);
                        } else {
                            r_ss_item_total += r_ss.ss_times * r_ss.ss_price;
                        }
                    }
                    r_ss_total += r_ss_item_total;
                    r_ss_table.push([
                        (r_ss.ss_everyday == 1 ? "everyday" : r_ss.ss_date),
                        (r_ss.ss_times).toFixed(0),
                        rs.schedule_services[r_ss.ss_id].v,
                        (r_ss.ss_instructions || '-'),
                        "$ "+ r_ss.ss_price,
                        (r_ss.ss_exclude_checkin ? 'yes' : 'no'),
                        (r_ss.ss_exclude_checkout ? 'yes' : 'no'),
                        "$ "+ r_ss_item_total.toFixed(2)
                    ]);
                });
                total += r_ss_total;
            }

            /** meds **/
            var is_r_meds = 0,
                r_meds_table = [],
                r_meds_total = 0;
            if (rs.ma(rb.r_meds).length > 0) {
                is_r_meds = 1;
                r_meds_table.push([
                    {text: rs.l.l('name'),          style: 'tableHeader'},
                    {text: rs.l.l('price'),          style: 'tableHeader'},
                    {text: rs.l.l('as_needed'),     style: 'tableHeader'},
                    {text: rs.l.l('instructions'),  style: 'tableHeader'},
                    {text: rs.l.l('med_type'),      style: 'tableHeader'},
                    {text: rs.l.l('dose_type'),     style: 'tableHeader'},
                    {text: rs.l.l('date'),          style: 'tableHeader'},
                    {text: rs.l.l('total'),         style: 'tableHeader'}
                ]);
                a.forEach(rb.r_meds, function(r_med){
                    var r_med_item_total = 0;
                    if (r_med.med_everyday) {
                        r_med_item_total += nr_days * rs.meds[r_med.med_id].price;
                    } else {
                        r_med_item_total += rs.meds[r_med.med_id].price;
                    }
                    r_meds_total += r_med_item_total;
                    r_meds_table.push([
                        rs.meds[r_med.med_id].v,
                        "$ "+ (rs.meds[r_med.med_id].price).toFixed(2),
                        (r_med.med_as_needed ? 'as needed' : '-'),
                        (r_med.med_instructions || '-'),
                        rs.meds_type[r_med.med_type_id].v,
                        (r_med.med_dosage_id ? rs.md_dosage[r_med.med_dosage_id].v : rs.md_dose_type[r_med.med_dose_type_id].v).toFixed(2),
                        (r_med.med_everyday ? 'daily' : r_med.med_date),
                        "$ "+ r_med_item_total
                    ]);
                });
                total += r_meds_total;
            }

            /** diets **/
            var is_r_diets = 0,
                r_diets_table = [],
                r_diets_total = 0;
            if (rs.ma(rb.r_diets).length > 0) {
                is_r_diets = 1;
                r_diets_table.push([
                    {text: rs.l.l('name'),          style: 'tableHeader'},
                    {text: rs.l.l('price'),          style: 'tableHeader'},
                    {text: rs.l.l('as_needed'),     style: 'tableHeader'},
                    {text: rs.l.l('instructions'),  style: 'tableHeader'},
                    {text: rs.l.l('diet_type'),      style: 'tableHeader'},
                    {text: rs.l.l('dose_type'),     style: 'tableHeader'},
                    {text: rs.l.l('date'),          style: 'tableHeader'},
                    {text: rs.l.l('total'),         style: 'tableHeader'}
                ]);
                a.forEach(rb.r_diets, function(r_diet){
                    var r_diet_item_total = 0;
                    if (r_diet.diet_everyday) {
                        r_diet_item_total += nr_days * rs.diets[r_diet.diet_id].price;
                    } else {
                        r_diet_item_total += rs.diets[r_diet.diet_id].price;
                    }
                    r_diets_total += r_diet_item_total;
                    r_diets_table.push([
                        rs.diets[r_diet.diet_id].v,
                        "$ "+ (rs.diets[r_diet.diet_id].price).toFixed(2),
                        (r_diet.diet_as_needed ? 'as needed' : '-'),
                        (r_diet.diet_instructions || '-'),
                        rs.diets_type[r_diet.diet_type_id].v,
                        (r_diet.diet_dosage_id ? rs.md_dosage[r_diet.diet_dosage_id].v : rs.md_dose_type[r_diet.diet_dose_type_id].v).toFixed(2),
                        (r_diet.diet_everyday ? 'daily' : r_diet.diet_date),
                        "$ "+ r_diet_item_total
                    ]);
                });
                total += r_diets_total;
            }
        }

        var docDefinition = {
            content: [
                {image: pdf.hr_image},
                {
                    text: type_of_report + "\n",
                    style: 'topTitle'
                },
                {
                    columns: [
                        {
                            width: '50%',
                            text: [
                                {
                                    text: rs.l.l('customer_name')+": "+ client_name +"\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: rs.l.l('email')+": "+ client_email +"\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: rs.l.l('contact_phone')+": "+ client_phone +"\n\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: rs.l.l('pet_name')+": "+ pet_name +"\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: rs.l.l('pet_type')+": "+ pet_type +"\n",
                                    style: 'subTitle'
                                },
                                {
                                    text: rs.l.l('pet_breed')+": "+ pet_breed +"\n\n\n",
                                    style: 'subTitle'
                                },
                                (tbl == 'r_boarding' ?
                                    {
                                        text:
                                            rs.l.l('stay_reason')+": "+ stay_reason +"\n" +
                                            rs.l.l('luggage')+": "+ luggage +"\n" +
                                            rs.l.l('is_handle_carefully')+": "+ is_handle_carefully +"\n" +
                                            rs.l.l('is_extra_pet')+": "+ is_extra_pet +"\n",
                                        style: 'subTitle3'
                                    } : {text:''}
                                ),
                                (tbl == 'r_grooms' ?
                                    {
                                        text:
                                            rs.l.l('pet_size')+": "+ pet_size_v +"\n" +
                                            rs.l.l('groomer')+": "+ groomer_v +"\n" +
                                            rs.l.l('grooming_rate')+": "+ grooming_rate_v +"\n" +
                                            rs.l.l('grooming_rate_multiplier')+": "+ grooming_rate_multiplier +"\n" +
                                            rs.l.l('is_handle_carefully')+": "+ is_hcp_v +"\n" +
                                            rs.l.l('base_type_service')+": "+ base_type_v +"\n",
                                        style: 'subTitle3'
                                    } : {text:''}
                                ),
                                (tbl == 'r_training' ?
                                    {
                                        text:
                                            rs.l.l('trainer')+": "+ trainer_v +"\n" +
                                            rs.l.l('training_group')+": "+ tg_v +"\n" +
                                            rs.l.l('limit')+": "+ tg_limit +"\n" +
                                            rs.l.l('price')+": $ "+ pF(tg_price).toFixed(2) +"\n" +
                                            rs.l.l('rank')+": "+ tg_rank +"\n" +
                                            rs.l.l('instructions')+": "+ tg_instructions +"\n" +
                                            rs.l.l('duration')+": "+ ts_duration +"\n",
                                        style: 'subTitle3'
                                    } : {text:''}
                                )
                            ]
                        },
                        {
                            width: '50%',
                            text: [
                                {
                                    text: rs.l.l('date_in')+": "+ date_in +"\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.l.l('time_in')+": "+ time_in +"\n\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.l.l('date_out')+": "+ date_out +"\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.l.l('time_out')+": "+ time_out +"\n\n",
                                    style: 'subTitle2'
                                },
                                (tbl == 'r_boarding' ?
                                    {
                                        text: rs.l.l('type')+": "+ c_type +" [ "+ c_v +" ]\n",
                                        style: 'subTitle2'
                                    } : {text:''}
                                ),
                                (tbl == 'r_daycare' ?
                                    {
                                        text: rs.l.l('type')+": "+ c_v +" \n",
                                        style: 'subTitle2'
                                    } : {text:''}
                                ),
                                ((tbl == 'r_boarding' || tbl == 'r_daycare') ?
                                    (!is_halfday  ?
                                        {
                                            text: rs.l.l('price_fullday')+": $ "+ c_fullday  +"\n",
                                            style: 'subTitle2'
                                        } : {
                                            text: rs.l.l('price_halfday')+": $ "+ c_halfday +"\n",
                                            style: 'subTitle2'
                                        }
                                    ) : {text:''}
                                ),
                                {
                                    text: rs.l.l('nr_days')+": "+ nr_days +"\n\n",
                                    style: 'subTitle2'
                                },
                                (is_r_ss ?
                                    {
                                        text: rs.l.l('schedule_services')+" - $ "+ pF(r_ss_total).toFixed(2) +"\n",
                                        style: 'subTitle2'
                                    } : {text:''}
                                ),
                                (is_r_meds ?
                                    {
                                        text: rs.l.l('meds')+" - $ "+ pF(r_meds_total).toFixed(2) +"\n",
                                        style: 'subTitle2'
                                    } : {text:''}
                                ),
                                (is_r_diets ?
                                    {
                                        text: rs.l.l('diets')+" - $ "+ pF(r_diets_total).toFixed(2) +"\n",
                                        style: 'subTitle2'
                                    } : {text:''}
                                ),
                                {
                                    text: "\n"+ rs.l.l('subtotal')+" - $ "+ pF(subtotal).toFixed(2) +"\n",
                                    style: 'subTitle2'
                                },
                                {
                                    text: rs.l.l('total').toUpperCase()+" - $ "+ pF(total).toFixed(2) +"\n\n",
                                    style: 'topTitle2'
                                }
                            ]
                        }
                    ]
                },
                (is_r_ss ?
                    {
                        text: rs.l.l('schedule_services') +" - $ "+ r_ss_total +"\n",
                        style: 'topTitle2'
                    } : {text:''}
                ),
                (is_r_ss ?
                    {
                        style: 'tableExample',
                        table: {
                            headerRows: 1,
                            widths: ['10%', '10%', '20%', '20%', '10%', '10%', '10%', '10%'],
                            body: r_ss_table
                        },
                        layout: 'lightHorizontalLines'
                    } : {text:''}
                ),
                (is_r_ss ? {text:"\n\n"} : {text:" "}),
                (is_r_meds ?
                    {
                        text: rs.l.l('meds') +" - $ "+ r_meds_total +"\n",
                        style: 'topTitle2'
                    } : {text:''}
                ),
                (is_r_meds ?
                    {
                        style: 'tableExample',
                        table: {
                            headerRows: 1,
                            widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto'],
                            body: r_meds_table
                        },
                        layout: 'lightHorizontalLines'
                    } : {text:''}
                ),
                (is_r_meds ? {text:"\n\n"} : {text:" "}),
                (is_r_diets ?
                    {
                        text: rs.l.l('diets') +" - $ "+ r_diets_total +"\n",
                        style: 'topTitle2'
                    } : {text:''}
                ),
                (is_r_diets ?
                    {
                        style: 'tableExample',
                        table: {
                            headerRows: 1,
                            widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto'],
                            body: r_diets_table
                        },
                        layout: 'lightHorizontalLines'
                    } : {text:''}
                ),
                (is_r_diets ? {text:"\n\n"} : {text:" "}),
                (tbl == 'r_grooms' ?
                    {
                        text: rs.l.l('grooming_services') +"\n",
                        style: 'topTitle2'
                    } : {text:''}
                ),
                (tbl == 'r_grooms' ?
                    {
                        style: 'tableExample',
                        table: {
                            headerRows: 1,
                            widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto'],
                            body: r_gs_table
                        },
                        layout: 'lightHorizontalLines'
                    } : {text:''}
                ),
                (tbl == 'r_grooms' ? {text:"\n\n"} : {text:" "}),
                (tbl == 'r_training' ?
                    {
                        text: rs.l.l('training_services') +"\n",
                        style: 'topTitle2'
                    } : {text:''}
                ),
                (tbl == 'r_training' ?
                    {
                        style: 'tableExample',
                        table: {
                            headerRows: 1,
                            widths: ['auto', 'auto', 'auto', 'auto', 'auto'],
                            body: r_t_table
                        },
                        layout: 'lightHorizontalLines'
                    } : {text:''}
                ),
                (tbl == 'r_training' ? {text:"\n\n"} : {text:" "})
            ],
            styles: pdf.styles
        };

        if (!without_print) {
            docDefinition.content.unshift(pdf.contactInfoHeader());
            var report_name = tbl+'_'+ rs.client.first_name +'_'+ rs.client.last_name +'_'+ rs.getCDT() +'.pdf';
            pdf.options(o.print_type, docDefinition, report_name);
        }

        return {
            total: total
        }

    };

};