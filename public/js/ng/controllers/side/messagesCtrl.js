/**
 * Messages Ctrl
 * @param api
 * @param $scope
 */
var messagesCtrl = function(api, $scope) {

    var s = $scope;

    s.d_dates = {
        target_date: 'date_created',
        ngChange: function() {
            s.checkUncheckAll(0);
        }
    };

    rs.initMessages = function() {
        s.message = {};
        s.selected_msg = [];
        s.current_msg = 'inbox';
        s.current_msg_list = rs.identity.messages.inbox;

        var query = '';
        a.forEach(rs.identity.messages.inbox, function(item){
            if (!item.is_read) {
                item.is_read = 1;
                query += "update `messages` set `is_read` = '"+ item.is_read +"' where `id` = '"+ item.id +"';";
            }
        });
        api.query('messages', query, 'multi_query').then(function(r){
            rs.identity.messages.unread = 0;
        });
    };

    s.setCurrentMsgList = function(type) {
        s.current_msg = type;
        s.current_msg_list = rs.identity.messages[type];
        s.checkUncheckAll(0, 'inbox');
        s.checkUncheckAll(0, 'sent');
        s.checkUncheckAll(0, 'deleted');
    };

    s.setSelectedMsg = function(m) {
        if (s.current_msg != 'deleted') {
            var arr = rs.identity.messages[s.current_msg];
            a.forEach(arr, function(item){
                if (item.id == m.id) {
                    item.check = (item.check ? 0 : 1);
                }
            })
        }
    };

    s.checkUncheckAll = function(v, current_msg) {
        var current_msg = (current_msg || s.current_msg),
            arr = rs.identity.messages[current_msg];
        a.forEach(arr, function(item){
            item.check = v;
        })
    };

    s.setColorHex = function(bg) {
        s.message.color_hex = bg;
    };

    s.deleteMsg = function(m) {
        rs.confirmMsg("Are you sure you want to delete this message ?", function(){
            m.is_deleted = 1;
            api.post('messages', m.id, m).then(function(r){
                a.forEach(s.current_msg_list, function(item, i){
                    if (item.id == m.id) {
                        s.current_msg_list.splice(i, 1);
                        return false;
                    }
                });
                rs.identity.messages.deleted.push(m);
                s.checkUncheckAll(0, 'deleted');
            });
        });
    };

    s.deleteCheckedMsg = function() {
        rs.confirmMsg("Are you sure you want to delete this message(s) ?", function(){
            var query = '',
                arr = [];
            a.forEach(s.current_msg_list, function(item, i){
                if (item.check) {
                    arr.push(i);
                    item.is_deleted = 1;
                    rs.identity.messages.deleted.push(item);
                    query += "update `messages` set `is_deleted` = '"+
                                item.is_deleted +"' where `id` = '"+ item.id +"';";
                }
            });
            a.forEach(arr.reverse(), function(i){
                s.current_msg_list.splice(i, 1);
            });
            api.query('messages', query, 'multi_query').then(function(){
                s.checkUncheckAll(0, 'deleted');
            });
        });
    };

    s.sendMsg = function() {
        if (s.message.inbox_user_id == rs.identity.id) {
            rs.alertMsg('Cannot send message to self');
        } else if (!s.message.message) {
            rs.alertMsg('Please enter a message to send');
        } else {
            rs.sh('.al_msg', '.btn_msg');
            if (s.message.inbox_user_id) {
                s.message.sent_user_id = rs.identity.id;
                api.post('messages', null, s.message).then(function(r){
                    rs.identity.messages.sent.push(r.data);
                    s.message = {};
                });
            } else {
                var query = '';
                a.forEach(rs.users, function(item, id){
                    if (id != rs.identity.id) {
                        query += "insert into `messages` set `sent_user_id` = '"+ rs.identity.id +
                                    "', `inbox_user_id` = '"+ id +"', `color_hex` = '"+ (s.message.color_hex || '') +
                                    "', `message` = '"+ s.message.message +"'; ";
                    }
                });
                api.query('messages', query, 'multi_query').then(function(r){
                    var filter = {filter: {message: s.message.message}};
                    api.get('messages', '', '', filter).then(function(r){
                        a.forEach(r.data, function(item){
                            rs.identity.messages.sent.push(item);
                        });
                        s.message = {};
                    });
                });
            }
            rs.alertMsg('Message(s) successfully sent to employee(s)');
            s.current_msg = 'sent';
            s.current_msg_list = rs.identity.messages.sent;
            rs.hs('.al_msg', '.btn_msg');
        }
    }
};