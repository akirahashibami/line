App.talk_room = App.cable.subscriptions.create("TalkRoomChannel",{

  connected:function(){
    // Called when the subscription is ready for use on the server
    console.log("connect");
  },

  disconnected:function(){
    // Called when the subscription has been terminated by the server
  },

  // データを送信
  received:function(data){
    return $('#chat-index').append('<li>' + data['talk'] + '</li>');
  },

  post:function(talk){
    return this.perform('post', { talk: talk });
  }

}, $(document).on('keypress', '[data-behavior~=chat_post]', function(e) {
  if (e.keyCode === 13) {
    let chatForm = $('#chat-form');
    App.talk_room.post(chatForm.val());
    return chatForm.val('');
  }
}));
