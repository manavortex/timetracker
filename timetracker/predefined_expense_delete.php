<?php
// +----------------------------------------------------------------------+
// | Anuko Time Tracker
// +----------------------------------------------------------------------+
// | Copyright (c) Anuko International Ltd. (https://www.anuko.com)
// +----------------------------------------------------------------------+
// | LIBERAL FREEWARE LICENSE: This source code document may be used
// | by anyone for any purpose, and freely redistributed alone or in
// | combination with other software, provided that the license is obeyed.
// |
// | There are only two ways to violate the license:
// |
// | 1. To redistribute this code in source form, with the copyright
// |    notice or license removed or altered. (Distributing in compiled
// |    forms without embedded copyright notices is permitted).
// |
// | 2. To redistribute modified versions of this code in *any* form
// |    that bears insufficient indications that the modifications are
// |    not the work of the original author(s).
// |
// | This license applies to this document only, not any other software
// | that it may be combined with.
// |
// +----------------------------------------------------------------------+
// | Contributors:
// | https://www.anuko.com/time_tracker/credits.htm
// +----------------------------------------------------------------------+

require_once('initialize.php');
import('form.Form');
import('ttPredefinedExpenseHelper');

// Access check.
if (!ttAccessCheck(right_manage_team) || !$user->isPluginEnabled('ex')) {
  header('Location: access_denied.php');
  exit();
}

$cl_predefined_expense_id = (int)$request->getParameter('id');
$predefined_expense = ttPredefinedExpenseHelper::get($cl_predefined_expense_id);
$predefined_expense_to_delete = $predefined_expense['name'];

$form = new Form('predefinedExpenseDeleteForm');
$form->addInput(array('type'=>'hidden','name'=>'id','value'=>$cl_predefined_expense_id));
$form->addInput(array('type'=>'submit','name'=>'btn_delete','value'=>$i18n->getKey('label.delete')));
$form->addInput(array('type'=>'submit','name'=>'btn_cancel','value'=>$i18n->getKey('button.cancel')));

if ($request->isPost()) {
  if ($request->getParameter('btn_delete')) {
    if(ttPredefinedExpenseHelper::get($cl_predefined_expense_id)) {
      if (ttPredefinedExpenseHelper::delete($cl_predefined_expense_id)) {
        header('Location: predefined_expenses.php');
        exit();
      } else
        $err->add($i18n->getKey('error.db'));
    } else
      $err->add($i18n->getKey('error.db'));
  } elseif ($request->getParameter('btn_cancel')) {
    header('Location: predefined_expenses.php');
    exit();
  }
} // isPost

$smarty->assign('predefined_expense_to_delete', $predefined_expense_to_delete);
$smarty->assign('forms', array($form->getName()=>$form->toArray()));
$smarty->assign('onload', 'onLoad="document.predefinedExpenseDeleteForm.btn_cancel.focus()"');
$smarty->assign('title', $i18n->getKey('title.delete_predefined_expense'));
$smarty->assign('content_page_name', 'predefined_expense_delete.tpl');
$smarty->display('index.tpl');
