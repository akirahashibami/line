$(document).ready(function(){

  // // サイドバーの設定を表示させる
  // 1.クックイベントの設定
  $(document).on('click', function(e){
    // 2.クリックされた場所の判定
    if(!$(e.target).closest('.user-other').length && !$(e.target).closest('#talk-room-other').length){
      $('.user-other').hide();
    } else if($(e.target).closest('#talk-room-other').length){
      // 3.ポップアップの表示状態の判定
      if($('.user-other').is(':hidden')){
        $('.user-other').show();
      } else {
        $('.user-other').hide();
      }
    }
  });

});
