<?php

    /**
     * @param array $json
     * @param string $api_method
     * @param bool $public_req
     * @param bool $url_encode
     * @param bool $debug
     * @return mixed
     */
    function api($json = array(), $api_method = '',
                 $public_req = false, $url_encode = true,
                 $debug = false, $is_single = true, $is_admin = false) {

        $identity = Zend_Auth::getInstance()->getIdentity();
        $config = Zend_Registry::get('__CONFIG__');
        $url = $config['api']['url'];
        $json_str = '';

        /** $api_method */
        if (!empty($api_method)) {
            $url .= '/'. $api_method;
        }

        /** json parameters */
        if (!empty($json)){
            $url .= array2String($json, $url_encode);
        }

        /** if public request */
        if ($public_req) {
            $url .= '&public=true';

        /** else send token */
        } else {
            $url .= '&token='. $identity['token']['token'];
        }

        /** @var add application_env $response_json */
        if ($is_admin) {
            $url .= '&env=k9_admin';
        } elseif ($is_single) {
            $url .= '&env='. APPLICATION_ENV;
        } else {
            $url .= '&env='. $_COOKIE['kennel'];
        }

        $response_json = file_get_contents($url);
        $response_array = json_decode($response_json, true);

        if ($debug) {
            d($url);
            dd($response_array);
        }

        return $response_array['r'];
    }

    /**
     * @param array $arr
     * @param bool $do_urlencode
     * @return string
     */
    function array2String($arr = array(), $do_urlencode = true) {

        $out = '?';
        foreach ($arr as $k => $v) {
            if (is_array($v)) {
                foreach ($v as $kk => $vv) {
                    $out .= $k.'['.$kk.']='. (($do_urlencode) ? urlencode($vv) : $vv) .'&';
                }
            } else {
                $out .= $k.'='. (($do_urlencode) ? urlencode($v) : $v) .'&';
            }
        }
        $out = trim($out, '&');
        return $out;
    }

    /**
     * array to string request
     * @param string $t
     * @param array $in
     * @param string $out
     * @return string
     */
    function array2Nvp($in = array(), $do_urlencode = true) {
        $out = '?';
        foreach ($in as $k => $v) {
            $out .=  $k .'='. (($do_urlencode) ? urlencode($v) : $v) .'&';
        }
        return $out;
    }

    /**
     * transorms array to array string
     * @param string $kN
     * @param array $in
     * @param bool $do_urlencode
     * @return array
     */
    function array2arrayNvp($kN = '', $in = array(), $do_urlencode = true) {
        $out = array();
        foreach ($in as $k => $v) {
            $out += array($kN.'['.$k.']' => $v);
        }
        return $out;
    }

    /**
     * Get resource from link
     * @param string $link
     * @return string
     */
    function l($link = '') {

        $config = Zend_Registry::get('__CONFIG__');
        $url = trim($config['api']['url'], 'api');

        return (!isNE($link) ? $url.$link : '');
    }

    /**
     * @return mixed
     */
    function apiUrl() {
        $config = Zend_Registry::get('__CONFIG__');
        return $config['api']['url'];
    }

    /**
     * @return mixed
     */
    function apiR() {
        $config = Zend_Registry::get('__CONFIG__');
        return $config['api']['r'];
    }

    /**
     * @return mixed
     */
    function apiL() {
        $config = Zend_Registry::get('__CONFIG__');
        return $config['api']['l'];
    }

    /**
     * @return mixed
     */
    function apiToken() {
        $identity = Zend_Auth::getInstance()->getIdentity();
        return $identity['token']['token'];
    }

    /**
     * @return mixed
     */
    function apiKennel() {
        return (isset($_COOKIE['kennel']) ? $_COOKIE['kennel'] : '');
    }

    /**
     * Zend_Debug::dump()
     */
    function d($in) {
        Zend_Debug::dump($in);
    }

    /**
     * Zend_Debug::dump()
     * die()
     */
    function dd($in) {
        Zend_Debug::dump($in);
        die;
    }

    /**
     * json_encode()
     */
    function jd($in) {
        return json_encode($in);
    }

    /**
     * Check if is_null or empty
     * @param mixed $in
     */
    function isNE($in) {
        return (is_null($in) || empty($in));
    }

    /**
     * Return if isset
     * @param mixed $array
     * @param mixed $key
     */
    function risI($array, $key) {
        return (isset($array[$key])) ? $array[$key] : null;
    }

    /**
     * Return yes or no according to 1 or 0
     */
    function yesNo($in) {
        return ($in == 1 || $in == true) ? 'yes' : 'no';
    }

    /**
     * Round with 2 decimals
     * @param $nr
     * @return string
     */
    function round2Nr($nr) {
        return sprintf('%0.2f', $nr);
    }

    /**
     * Convert array 2 json
     * @param $js_var
     * @param $array
     * @return string
     */
    function array2Json($array) {
        $identity_json = '';
        if (isset($array)) {
            foreach ($array as $k => $v) {
                if (is_array($v)) {
                    $identity_json .= $k.": {";
                    foreach($v as $kk => $vv) {
                        $identity_json .= $kk.": '$vv',";
                    }
                    $identity_json = trim($identity_json, ',');
                    $identity_json .= "},";
                } else {
                    $identity_json .= $k.": '$v',";
                }
            }
            $identity_json = trim($identity_json, ',');
            return $identity_json;
        }
    };

    function compress_page($buffer) {
//        $search = array(
//            "/ +/" => " ",
//            "/<!--(.*?)-->|[\t\r\n]|<!--|-->|\/\/ <!--|\/\/ -->|<!--\[CDATA\[|\/\/ \]\]-->|\]\]&gt;|\/\/\]\]&gt;|\/\/<!--\[CDATA\[/" => ""
//        );
//        $buffer = preg_replace(array_keys($search), array_values($search), $buffer);
        return $buffer;
    }
