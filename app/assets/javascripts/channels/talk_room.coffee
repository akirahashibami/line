$ ->
  talkForm = $('#talk-form')

  App.talk_room = App.cable.subscriptions.create { channel: "TalkRoomChannel", room_id: talkForm.data('room')},

    # 通信が確立された時
    connected: ->

    # 通信が切断された時
    disconnected: ->

    # 値を受け取った時
    received: (data) ->
      # サーバーサイドから値を受け取りviewに追加する
      $('#talk').append("<p>"+data["talk"]+"</p>");

    speak: (talk) ->
      # サーバーサイド(channel)のspeakアクションにtalkパラメータを渡す
      @perform 'speak', talk: talk

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    # return(Enter)が押された時
    if event.keyCode is 13
      # channel speakへ, event.target.valueを引数に
      App.talk_room.speak [event.target.value, $('[data-user]').attr('data-user'), $('[data-room]').attr('data-room')]
      event.target.value = ''
      event.preventDefault()
