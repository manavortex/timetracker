{include file="time_script.tpl"}
<script type="text/javascript">
  setDurationInput("{$i18n.form.time.duration_format}");
</script>

<style>
.not_billable td {
  color: #ff6666;
}
</style>

{$forms.timeRecordForm.open}
<table id="timeRecordTable" cellspacing="4" cellpadding="0" border="0">
  <tr>
    <td>
      <table id="tableTimeRecordEntry">
{if $on_behalf_control}
        <tr>
          <td id="tdUser" align="right">{$i18n.label.user}:</td>
          <td id="tdUserForm" >{$forms.timeRecordForm.onBehalfUser.control}</td>
        </tr>
{/if}
{if $user->isPluginEnabled('cl')}
        <tr>
          <td id="tdClient" align="right">{$i18n.label.client}{if $user->isPluginEnabled('cm')} (*){/if}:</td>
          <td id="tdClientForm" >{$forms.timeRecordForm.client.control}</td>
        </tr>
{/if}
{if $user->isPluginEnabled('iv')}
        <tr>
          <td id="tdPlugin" align="right">&nbsp;</td>
          <td id="tdPluginForm"><label>{$forms.timeRecordForm.billable.control}{$i18n.form.time.billable}</label></td>
        </tr>
{/if}
{if ($custom_fields && $custom_fields->fields[0])}
        <tr>
          <td id="tdCustomFields" align="right">{$custom_fields->fields[0]['label']|escape}{if $custom_fields->fields[0]['required']} (*){/if}:</td><td>{$forms.timeRecordForm.cf_1.control}</td>
        </tr>
{/if}
{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <tr>
          <td id="tdProjects" align="right">{$i18n.label.project} (*):</td>
          <td id="tdProjectsForm">{$forms.timeRecordForm.project.control}</td>
        </tr>
{/if}
{if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <tr>
          <td id="tdTask" align="right">{$i18n.label.task}:</td>
          <td id="tdTaskForm">{$forms.timeRecordForm.task.control}</td>
        </tr>
{/if}
{if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <tr>
          <td id="tdStart" align="right">{$i18n.label.start}:</td>
          <td id="tdStartForm">{$forms.timeRecordForm.start.control}&nbsp;<input onclick="setNow('start');" type="button" tabindex="-1" value="{$i18n.button.now}"></td>
        </tr>
        <tr>
          <td id="tdFinish" align="right">{$i18n.label.finish}:</td>
          <td id="tdFinishForm">{$forms.timeRecordForm.finish.control}&nbsp;<input onclick="setNow('finish');" type="button" tabindex="-1" value="{$i18n.button.now}"></td>
        </tr>
{/if}
{if (($smarty.const.TYPE_DURATION == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <tr>
          <td id="tdDuration" align="right">{$i18n.label.duration}:</td>
          <td id="tdDurationForm">{$forms.timeRecordForm.duration.control}</td>
        </tr>
{/if}
        <tr>
          <td id="tdNote" align="right">{$i18n.label.note}:</td>
          <td id="tdNoteForm" align="left">{$forms.timeRecordForm.note.control}</td>
        </tr>

      </table>
    </td>
    <td>
      <table id="tableDatePicker">
        <tr><td id="tdDate">{$forms.timeRecordForm.date.control}</td></tr>
        <tr>
          <td id="tdSubmit" align="center" colspan="2">{$forms.timeRecordForm.btn_submit.control}</td>
        </tr>
      </table>      
    </td>
  </tr>
  </tr>
  <td>
    <table id="tableNote">
      <tr>
        
      </tr>
      
    </table>
  </td>
  <td></td>
  </tr>
</table>



<table width="720">
<tr>
  <td>
{if $time_records}
      <table border="0" cellpadding="3" cellspacing="1" width="100%">
      <tr>
  {if $user->isPluginEnabled('cl')}
        <td width="20%" class="tableHeader">{$i18n.label.client}</td>
  {/if}
  {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td class="tableHeader">{$i18n.label.project}</td>
  {/if}
  {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td class="tableHeader">{$i18n.label.task}</td>
  {/if}
  {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <td width="5%" class="tableHeader" align="right">{$i18n.label.start}</td>
        <td width="5%" class="tableHeader" align="right">{$i18n.label.finish}</td>
  {/if}
        <td width="5%" class="tableHeader">{$i18n.label.duration}</td>
        <td class="tableHeader">{$i18n.label.note}</td>
        <td width="5%" class="tableHeader">{$i18n.label.edit}</td>
      </tr>
  {foreach $time_records as $record}
      <tr bgcolor="{cycle values="#f5f5f5,#ccccce"}" {if !$record.billable} class="not_billable" {/if}>
    {if $user->isPluginEnabled('cl')}
        <td>{$record.client|escape}</td>
    {/if}
    {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td>{$record.project|escape}</td>
    {/if}
    {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td>{$record.task|escape}</td>
    {/if}
    {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <td nowrap align="right">{if $record.start}{$record.start}{else}&nbsp;{/if}</td>
        <td nowrap align="right">{if $record.finish}{$record.finish}{else}&nbsp;{/if}</td>
    {/if}
        <td align="right">{if ($record.duration == '0:00' && $record.start <> '')}<font color="#ff0000">{$i18n.form.time.uncompleted}</font>{else}{$record.duration}{/if}</td>
        <td>{if $record.comment}{$record.comment|escape}{else}&nbsp;{/if}</td>
        <td valign="top" align="center">
    {if $record.invoice_id}
          &nbsp;
    {else}
          <a href="time_edit.php?id={$record.id}">{$i18n.label.edit}</a>
      {if ($record.duration == '0:00' && $record.start <> '')}
          <input type="hidden" name="record_id" value="{$record.id}">
          <input type="hidden" name="browser_date" value="">
          <input type="hidden" name="browser_time" value="">
          <input type="submit" id="btn_stop" name="btn_stop" onclick="browser_date.value=get_date();browser_time.value=get_time()" value="{$i18n.button.stop}">
      {/if}
    {/if}
        </td>
      </tr>
  {/foreach}
    </table>
{/if}
  </td>
</tr>
</table>
{if $time_records}
<table cellpadding="3" cellspacing="1" width="720">
  <tr>
    <td align="left">{$i18n.label.week_total}: {$week_total}</td>
    <td align="right">{$i18n.label.day_total}: {$day_total}</td>
  </tr>
  {if $user->isPluginEnabled('mq')}
  <tr>
    <td align="left">{$i18n.label.month_total}: {$month_total}</td>
    {if $over_quota}
    <td align="right">{$i18n.form.time.over_quota}: <span style="color: green;">{$quota_remaining}</span></td>
    {else}
    <td align="right">{$i18n.form.time.remaining_quota}: <span style="color: red;">{$quota_remaining}</span></td>
    {/if}
  </tr>
  {/if}
</table>
{/if}
{$forms.timeRecordForm.close}
