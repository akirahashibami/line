javascript:
  $(document).ready(function(){

    // サイドバークリックで画面を切り替える
    $('.tab-btn').on('click',function(){
      // セレクタ切り替え
      let element = $(this);
      let TabWrap = element.parents('.talk-room-index__sidebar--main');
      let ContentWrap = $('.talk-room-index__talk-rooms')
      let TabBtn = TabWrap.find('.tab-btn');
      let TabContents = ContentWrap.find('.tab-content');
      // current class
      let currentClass = 'is-show';
      // tab-btn current 切り替え
      TabBtn.removeClass(currentClass);
      element.addClass(currentClass);
      // クリックされたtabが何番目か取得
      let elementIndex = TabBtn.index(this);
      // tab-content切り替え
      TabContents.removeClass(currentClass);
      TabContents.eq(elementIndex).addClass(currentClass);
    });

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

    // グループと友だちのプルダウンを設定
    $('.talk-rooms__list--groups').on('click','.select-group-list',function(){
      let parent = $(this).closest('.talk-rooms__list--groups');
      // クラス名がついてるか判断しつけ外しを行う
      if(!parent.hasClass('is-open')){
        parent.addClass('is-open');
      } else {
        parent.removeClass('is-open');
      }
    });
    $('.talk-rooms__list--friends').on('click','.select-friends-list',function(){
      let parent = $(this).closest('.talk-rooms__list--friends');
      // クラス名がついてるか判断しつけ外しを行う
      if(!parent.hasClass('is-open')){
        parent.addClass('is-open');
      } else {
        parent.removeClass('is-open');
      }
    });

    // おすすめと知り合いかも？のプルダウンを設定
    $('.acquaintancers').on('click','.maybe-acquaintance',function(){
      let parent = $(this).closest('.acquaintancers');
      // クラス名がついているか判断しつけ外しを行う
      if(!parent.hasClass('is-open')){
        parent.addClass('is-open');
      } else {
        parent.removeClass('is-open');
      }
    });

    // // 友だちをクリックでトークを表示させる
    // $('.user-talk-show').on('click',function(){
    //   // クリックされた友だちのidを取得
    //   // ajaxでtalk_room.indexを呼ぶ
    //   $.ajax({
    //     url: "talk_rooms",
    //     type: "GET",
    //     data: {user_id : $('#user-talk-show').data('data-id')},
    //     datatype: "html"
    //   })
    //   .done(function(data){
    //     $("#talks").html("#{j(render partial: 'user-talk-index', locals: { user: @user})}");
    //   })
    //   .fail(function(){
    //     alert("error!");
    //   })

  });
