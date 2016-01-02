<?php

class IndexController extends KM_Abstract
{
    public function indexAction() {}

    public function showAction() {
        if (isset($this->_params['no_layout'])) {
            $this->_helper->layout->disableLayout();
        }
        $this->_helper->viewRenderer($this->_params['view']);
    }

    public function partialsAction() {
        $this->_helper->layout->disableLayout();
    }

    public function crudAction() {
        $this->_helper->layout->disableLayout();
    }

    public function selectKennelAction() {
        $this->_helper->layout->disableLayout();
    }

    public function adminKennelAction() {
        $this->_helper->layout->disableLayout();
    }


}