$(document).ready(function(){

  // ログイン画面で何も入力しないとボタンを押せないようにする
  const $submitBtn = $('#submit')
  const $session_actions = $('.session__actions');
  $(window).load(function(){
    $($submitBtn).prop('disabled', true);
  });
  $('#new_user input').on('keyup keydown', function(){
    if (
      $('#new_user input[type="email"]').val() !== "" &&
      $('#new_user input[type="password"]').val() !== ""
    ) {
      $submitBtn.prop('disabled', false);
      $session_actions.addClass("session__hover");
      $session_actions.removeClass("session__actions");
    } else {
      $submitBtn.prop('disabled', true);
      $session_actions.addClass("session__actions");
      $session_actions.removeClass("session__hover")
    }
  });

  // パスワード入力時には目のアイコンを表示する
  $('input[name="user[password]"]').on('load keyup', function(){
    if ($(this).val() === ""){
      $('#pass_check').css({ 'display' : 'none'});
    } else {
      $('#pass_check').css({ 'display' : 'block'});
    }
  });

  // パスワード表示ボタンを作る
  $(function(){
    let password = '#password';
    let pass_check = '#pass_check';

    $(pass_check).mousedown(function(){
      $(password).attr('type','text');
      $(pass_check).css({ 'color' : '#0a0'});
    }).mouseup(function(){
      $(password).attr('type','password');
      $(pass_check).css({ 'color' : '#ddd'})
    });
  });

});
