$ ->
  talkForm = $('#talk_form')

  App.talk_room = App.cable.subscriptions.create { channel: "TalkRoomChannel", room_id: talkForm.data('room')},

    # 通信が確立された時
    connected: ->

    # 通信が切断された時
    disconnected: ->

    # 値を受け取った時
    received: (data) ->
      # サーバーサイドから値を受け取りviewに追加する
      if data["talk"] != null
        if data['user_id'] == $('#talk').data('user_id')
          $('#talk').append('<div class="user-talk-index__talks--right">'+
                              '<div class="time">'+'<span>'+data["created_at"]+'</span>'+'</div>'+
                              '<div class="talk">'+  data["talk"]+'</div>'+
                              '</div>')
        else
          $('#talk').append('<div class="user-talk-index__talks--left">'+
                              '<div class="talk">'+  data["talk"]+'</div>'+
                              '<div class="time">'+'<span>'+data["created_at"]+'</span>'+'</div>'+
                              '</div>')
      else
        $('#talk').append data['talkhtml']

      scroll = $('.user-talk-index__talks');
      scroll.scrollTop(10000);

      # トークの追加があったトークルームを最上段に表示させる
      $('.talk__friends--list').prepend($('.talk-room-' + data["talk_room_id"]));
      # 内容を書き換える
      $('.talk-room-' + data["talk_room_id"]).find(
        $('#latest-talk').html('<span class="latest-talk-show__name-display--display">'+
                                  data["talk"]+
                                '</span>')
      )
      # 時間も書き換える
      $('#data-time').html('<span id="data-time">'+
                              data["created_at"]+
                            '</span>')

    speak: (talk) ->
      # サーバーサイド(channel)のspeakアクションにtalkパラメータを渡す
      @perform 'speak', talk: talk

    sendImage: (data_uri, file_name, user, room) ->
      @perform 'send_image', {data_uri: data_uri, user: user, room: room}
      clear_form '.user-talk-index__file--left'

  # フォームリセット
  clear_form = (selector) ->
    $(selector).find(":text, :file").val("")

  # チャットを送る
  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    # return(Enter)が押された時
    if event.keyCode is 13
      # channel speakへ, event.target.valueを引数に
      App.talk_room.speak [event.target.value, $('[data-user]').attr('data-user'), $('[data-room]').attr('data-room')]
      event.target.value = ''
      event.preventDefault()

  # 画像を送る
  $(document).on 'change', '[data-behavior~=room_image]', (event) ->
    image = $('#send-file-form')
    has_image = if image.get(0).files.length > 0 then true else false

    if has_image
      file_name = image.get(0).files[0].name
      # ファイル読み込み用のreader生成
      reader = new FileReader()
      # Data URI Scheme文字列を取得するためのファイル読み込み
      reader.readAsDataURL image.get(0).files[0]
      # readerが画像を読み込んだ後の処理
      reader.addEventListener "loadend", ->
        # reader.result部分が読み込んだ画像のData URI Scheme文字列
        App.talk_room.sendImage reader.result, file_name, $('[data-user]').attr('data-user'), $('[data-room]').attr('data-room')
    event.preventDefault()
