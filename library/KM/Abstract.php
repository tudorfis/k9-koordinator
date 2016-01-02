<?php

abstract class KM_Abstract extends Zend_Controller_Action 
{
    protected $_config;
    protected $_identity;
    protected $_params;

    public function init() {

        /* Initialize config */
        $this->_config = Zend_Registry::get('__CONFIG__');
        Zend_Layout::getMvcInstance()->getView()->config = $this->_config;
        
        /* Initialize identity */
        $this->_identity = Zend_Auth::getInstance()->getIdentity();
        Zend_Layout::getMvcInstance()->getView()->identity = $this->_identity;
        
        /* Initialise params */
        $this->_params = $this->getRequest()->getParams();
        $this->_params['view'] = (!isset($this->_params['view']) ? '' : $this->_params['view']);
        Zend_Layout::getMvcInstance()->getView()->params = $this->_params;

    }
    
    public function preDispatch() {
        if (isset($_REQUEST['kennel'])) {
            setcookie("kennel", $_REQUEST['kennel'], time()+3600*24*30);
            header("Location: /".APPLICATION_ENV."/logout");
        } elseif (isset($_COOKIE['kennel'])) {
            if (is_null(Zend_Auth::getInstance()->getIdentity()) &&
                    !in_array($this->_params['action'], array('login', 'select-kennel', 'admin-kennel'))) {
                $this->redirect('/login');
            }
        } else {
            if ($this->_params['action'] != 'select-kennel') {
                $this->redirect('select-kennel');
            }
        }
    }
    
}
