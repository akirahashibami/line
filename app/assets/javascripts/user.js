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


  // ユーザーエディット言語選択プルダウン
  // 言語選択が押された時（'click'の後にクラス名を指定でそこもターゲットに）
  $('.language-select').on('click','.language-select-placeholder',function(){
    // 親要素 .language-selectまでを取得
    let parent = $(this).closest('.language-select');
    // クラス名がついているか判断し、付け外しを行う
    if( ! parent.hasClass('is-open')){
      parent.addClass('is-open');
    } else {
      parent.removeClass('is-open');
    }
    // さらにその中のli要素が押された時に
  }).on('click', 'ul>li', function(){
    let parent = $(this).closest('.language-select');
    // クラスを取り除きクラス名placeholderのテキストをクリックしたテキストに上書き
    parent.removeClass('is-open').find('.language-select-placeholder').text($(this).text());
    // 選択された言語のvalueをinputに持たせる(これで選択したvalueを送る)
    parent.find('input[type=hidden]').attr('value',$(this).attr('data-value'));
  });

});
