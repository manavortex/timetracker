{$forms.fileForm.open}
<table cellspacing="4" cellpadding="7" border="0">
  <tr>
    <td>
      <table cellspacing="1" cellpadding="2" border="0">
        <tr>
          <td align = "right">{$i18n.label.thing_name} (*):</td>
          <td>{$forms.fileForm.file_name.control}</td>
        </tr>
        <tr>
          <td align = "right">{$i18n.label.description}:</td>
          <td>{$forms.fileForm.description.control}</td>
        </tr>
        <tr>
          <td></td>
          <td>{$i18n.label.required_fields}</td>
        </tr>
        <tr>
          <td></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" align="center" height="50">{$forms.fileForm.btn_save.control}</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
{$forms.fileForm.close}
