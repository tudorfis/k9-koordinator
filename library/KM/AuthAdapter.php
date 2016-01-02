<?php

 
class KM_AuthAdapter implements Zend_Auth_Adapter_Interface {

    protected $username;
    protected $password;

    public function setUsernamePass ($username, $password) {
        $this->username = $username;
        $this->password = $password;
    }

    public function authenticate()
    {
        $json = array(
            'table'   => 'users'
        );
        $json += array('filter[username]' => $this->username,
                       'filter[password]' => $this->password);

        $code = Zend_Auth_Result::FAILURE;
        $errMessage = "Username or password incorrect";

        $response = api($json, '', true, true, false, false);
        $user = $response['data'];

        if (!empty($user)) {
            $user = $user[0];

            /* 'active' */
            if ($user['status_id'] == 1){

                /** get token */
                $user['token']  = self::getToken($user['id']);

                $code = Zend_Auth_Result::SUCCESS;
                $result = new Zend_Auth_Result(Zend_Auth_Result::SUCCESS, $user, array());
                return $result;
            }

            /* 'inactive' */
            if ($user['status_id'] == 2) {
                $code = Zend_Auth_Result::FAILURE;
                $errMessage = "Your account is currently inactive. Please contact us for details";
            }

        }
        
        $result = new Zend_Auth_Result($code, null, array($errMessage));
        return $result;
    }

    /** get token */
    static public function getToken($identity_id) {
        $token = array(
            'user_id'     => $identity_id,
            'device_id'   => KM_Utils::getDeviceId(),
            'token'       => KM_Utils::getTokenFromSession(),
            'date'        => date('Y-m-d'),
            'start_time'  => date('H:i:s')
        );
        return $token;
    }

    /** save token */
    static public function saveStartToken($token) {

        /* Create API Token */
        $json = array(
            'table'            => 'tokens',
            'data[user_id]'    => $token['user_id'],
            'data[device_id]'  => $token['device_id'],
            'data[token]'      => $token['token'],
            'data[date]'       => $token['date'],
            'data[start_time]' => $token['start_time']
        );
        api($json, 'post', true, true, false, false);
    }

    /** clear token */
    static public function saveEndToken() {

        $identity = Zend_Auth::getInstance()->getIdentity();
        $end_time = date('H:i:s');
        $end_time_timestamp = strtotime($end_time);

        $start_time = $identity['token']['start_time'];
        $start_time_timestamp = strtotime($start_time);

        $total_time_timestamp = $end_time_timestamp - $start_time_timestamp;
        $total_time = gmdate('H:i:s', $total_time_timestamp);

        $json = array(
            'table'              => 'tokens',
            'filter[id_n]'       => 'user_id',
            'filter[id_v]'       => $identity['id'],
            'filter[token]'      => $identity['token']['token'],
            'data[end_time]'     => $end_time,
            'data[total_time]'   => $total_time,
        );
        api($json, 'post', true, true, false, false);
    }

}
