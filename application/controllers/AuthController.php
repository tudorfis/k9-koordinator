<?php

class AuthController extends KM_Abstract
{
    public function init() {
        parent::init();
    }

    public function loginAction() 
    {
        /** Redirect **/
        if (!is_null($this->_identity)) {
            $this->redirect('/');
        }

        /** Select all the employees */
        $r_users = api(array('table' => 'users'), '', false, true, false, false);
        $r_role  = api(array('table' => 'role'), '', false, true, false, false);
        $users_array = array();

        sort($r_role['data']);
        foreach ($r_role['data'] as $role) {
            foreach ($r_users['data'] as $user) {
                if ($role['id'] == $user['role_id']) {
                    $users_array[$role['v']][] = $user;
                }
            }
        }
        $this->view->assign('users_array', $users_array);

        /** Make login **/
        if($this->getRequest()->isPost())
        {
            $auth = Zend_Auth::getInstance();
            if (isset($this->_params['username']) && !empty($this->_params['username'])) {

                $username = strtolower($this->_params["username"]);
                $password = $this->_params["password"];

                $authAdapter = new KM_AuthAdapter();
                $authAdapter->setUsernamePass($username, $password);
                $result = $auth->authenticate($authAdapter);

                if ($result->isValid()) {

                    $identity = $auth->getIdentity();
                    $identity_id = $identity['id'];

                    KM_AuthAdapter::saveStartToken($identity['token']);
                    $this->redirect('/');

                }

                $errorMessage = $result->getMessages();
                $this->view->assign("username",     $username);
                $this->view->assign("errorMessage", $errorMessage[0]);
                $this->view->assign("errorCode",    $result->getCode());


            }

        }
    }
    
    public function logoutAction() {
        
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        /** clear token */
        KM_AuthAdapter::saveEndToken();

        $namespace = new Zend_Session_Namespace();
        unset($namespace);

        Zend_Auth::getInstance()->clearIdentity();
        $this->redirect("/");
    }

}

