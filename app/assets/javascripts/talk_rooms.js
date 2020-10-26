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

    // 名前で検索機能を作る
    $(document).ready(function(){
      const inputForm = $('#searching-form');
      const url = location.href;
      const searchResult = $('.result');

      function builtHTML(data){
        if(data.profile_image === null){
          let html = `<a class="user-talk-show" data-remote="true" href="/talk_rooms?follower=${data.id}">
                      <img src="${data.profile_image}">
                      <p>${data.name}</p>
                      `
          searchResult.append(html);
        }else{
          let html = `<a class="user-talk-show" data-remote="true" href="/talk_rooms?follower=${data.id}">
                      <img src="/assets/usagi.jpg">
                      <p>${data.name}</p>
                      `
          searchResult.append(html);
        }
      }
      function NoResult(message){
        let html = `<li>${message}</li>`
        searchResult.append(html);
      }
      // フォームに入力でイベント発火
      inputForm.on('keyup', function(e){
        e.preventDefault();
        let target = $(this).val();
        if(target !== ''){
          search(target);  // ajax通信はsearch()という関数に
          $('.talk-rooms-content').addClass("talk-rooms-content-close");
        }else{
          searchResult.empty();
          $('.talk-rooms-content').removeClass("talk-rooms-content-close");
        }
      });
      // ajax処理
      function search(target){
        $.ajax({
          type: 'GET',
          url: '/talkrooms/search',
          data: {keyword: target},
          dataType: 'json'
        })
        .done(function(data){
          searchResult.empty(); // 再度検索した際に前のデータを消す処理
          if (data.length !== 0){
            data.forEach(function(data){ // dataは配列型に格納されているのでeachぶんで回す
              builtHTML(data)
            });
          }else{
            NoResult('検索結果がありません')
          }
        })
        .fail(function(data){
          alert('通信に失敗しました')
        })
      }
    });

  });
