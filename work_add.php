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
import('ttProjectHelper');
import('ttGroupHelper');
import('ttFileHelper');
import('ttWorkHelper');

// Access checks.
if (!ttAccessAllowed('manage_work')) {
  header('Location: access_denied.php');
  exit();
}
if (!$user->isPluginEnabled('wk')) {
  header('Location: feature_disabled.php');
  exit();
}
// End of access checks.

$showFiles = $user->isPluginEnabled('at');

if ($request->isPost()) {
  $cl_name = trim($request->getParameter('work_name'));
  $cl_description = trim($request->getParameter('description'));
  $cl_currency = $request->getParameter('currency');
}

$form = new Form('workForm');
$form->addInput(array('type'=>'text','maxlength'=>'100','name'=>'work_name','style'=>'width: 250px;','value'=>$cl_name));
$form->addInput(array('type'=>'textarea','name'=>'description','style'=>'width: 250px; height: 40px;','value'=>$cl_description));
if ($showFiles)
  $form->addInput(array('type'=>'upload','name'=>'newfile','value'=>$i18n->get('button.submit')));
// Add a dropdown for currency.
$currencies = ttWorkHelper::getCurrencies();
$form->addInput(array('type'=>'combobox','name'=>'currency','data'=>$currencies,'datakeys'=>array('id','name'),'value'=>$cl_currency));

// TODO: design how to handle one-time vs ongoing work. Apparently, with a conditional display of relevant controls.
// Ongoing work - rate per hour control.
// One-time work - budget dropdown control.
// When selection changes, we hide and show required controls.

// TODO: design how to handle categories and sub-categories.
// One major complication is localization of names.

// Coding and design are currently ongoing.


if ($request->isPost()) {
  // Validate user input.
  if (!ttValidString($cl_name)) $err->add($i18n->get('error.field'), $i18n->get('label.thing_name'));
  if (!ttValidString($cl_description, true)) $err->add($i18n->get('error.field'), $i18n->get('label.description'));
  if (!ttGroupHelper::validateCheckboxGroupInput($cl_users, 'tt_users')) $err->add($i18n->get('error.field'), $i18n->get('label.users'));
  if (!ttGroupHelper::validateCheckboxGroupInput($cl_tasks, 'tt_tasks')) $err->add($i18n->get('error.field'), $i18n->get('label.tasks'));

  if ($err->no()) {
    if (!ttProjectHelper::getProjectByName($cl_name)) {
      $id = ttProjectHelper::insert(array('name' => $cl_name,
        'description' => $cl_description,
        'users' => $cl_users,
        'tasks' => $cl_tasks,
        'status' => ACTIVE));

      // Put a new file in storage if we have it.
      if ($id && $showFiles && $_FILES['newfile']['name']) {
        $fileHelper = new ttFileHelper($err);
        $fields = array('entity_type'=>'project',
          'entity_id' => $id,
          'file_name' => $_FILES['newfile']['name']);
        $fileHelper->putFile($fields);
      }
      if ($id) {
        header('Location: projects.php');
        exit();
      } else
        $err->add($i18n->get('error.db'));
    } else
      $err->add($i18n->get('error.object_exists'));
  }
} // isPost

$smarty->assign('forms', array($form->getName()=>$form->toArray()));
$smarty->assign('onload', 'onLoad="document.projectForm.project_name.focus()"');
$smarty->assign('show_files', $showFiles);
$smarty->assign('show_users', count($users) > 0);
$smarty->assign('show_tasks', $show_tasks);
$smarty->assign('title', $i18n->get('title.add_work'));
$smarty->assign('content_page_name', 'work_add.tpl');
$smarty->display('index.tpl');
