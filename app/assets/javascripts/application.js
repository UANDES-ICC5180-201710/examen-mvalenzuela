// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


function purchaseEvent(e) {
  var target = e.target;
  var value = target.value;
  if ( target.classList.contains('btn-success') ){
    target.classList.remove('btn-success');
  }

  else{
    target.classList.add('btn-success');
  }
  var result
  $.ajax({
          type: "POST",
          url: "ajaxFunction",
          data: {
          "game_id" : value
          },
          datatype: 'json',
          success: function(json){
            answer = json["answer"]
            console.log("la respuesta desde el servidor es:", answer)
          }
      })
}
