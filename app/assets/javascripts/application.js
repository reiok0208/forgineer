// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .
//= require select2

//diary#index
function select(value) {
  var search = $(".search").val();
  var name = $(".name").val();
  var tag_id = $(".tag_id").val();
  var nickname = $(".nickname").val();
  var user_id = $(".user_id").val();
  if (typeof search !== 'undefined') {
    window.location.replace('/diaries?search=' + search + '&option=' + value);
  }else if (typeof tag_id !== 'undefined'){
    window.location.replace('/diaries?name=' + name + '&tag_id=' + tag_id + '&option=' + value);
  }else if (typeof user_id !== 'undefined'){
    window.location.replace('/diaries?nickname=' + nickname + '&user_id=' + user_id + '&option=' + value);
  }else{
    window.location.replace('/diaries?option=' + value );
  }
}

//home#about
//div要素をゆっくり表示
$('div').hide().fadeIn('slow');
function Click(btn) {
  if (btn == 1) {
    //onClick="Click1"が押された時
    var content = "素晴らしい記憶力をお持ちなんですね！<br>その記憶をForgineerに残してみませんか？", select = "yes", noselect = "no";
    
  } else if (btn == 2) {
    //onClick="Click2"が押された時
    var content = "記憶力に自信がなくても大丈夫です！<br>Forgineerに記憶を残して必要なときにアウトプットしてみましょう！", select = "no", noselect = "yes";
  }
  $('p').hide().fadeIn('slow');
  document.getElementById(select).innerHTML = content;
  document.getElementById(noselect).style.display = "none";
}

//_post.html.erb gem select2


//_profile.html.erb gem drawer
$(function () {
  $('.drawer').drawer();
});

//user#new user#edit
function countLength( text, field ) {
  document.getElementById(field).innerHTML = 160 - text.length + "文字";
}