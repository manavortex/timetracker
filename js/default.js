/* replaces window.onload */
function onLoadRunJavascript() {
  
}



function setDurationInput(defaultValue){
  var durationInput = $("input#duration");
  if (durationInput) {
    defaultValue = "\"" + defaultValue + "\""
    durationInput.value = defaultValue;
    durationInput.onblur = function() {
      if (this.value == '') {this.value = defaultValue;}
    }
    durationInput.onfocus = function() {
      if (this.value == defaultValue) {this.value = '';}
    }
  }  
}
