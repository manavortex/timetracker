/* replaces window.onload */
$(document).ready(function() {

})

function setDurationInput(defaultValue){
  var durationInput = document.getElementById('duration');
  defaultValue = defaultValue.replace("(", "").replace(")", "")
  if (durationInput) {
    durationInput.style.color = "silver";
    durationInput.value = defaultValue;
    durationInput.onblur = function() {
      if (this.value == '') {
        this.value = defaultValue;
        this.style.color = "silver";
      }
    }
    durationInput.onfocus = function() {
      if (this.value == defaultValue) {
        this.value = '';
        this.style.color = "black";

      }
      
    }
  }  
}
