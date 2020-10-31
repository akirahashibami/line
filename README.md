## チャット機能
- ActionCable使用

## gem
- gem 'devise'
- gem 'devise_token_auth'
- gem 'bootstrap', '~> 4.1.1'
- gem 'jquery-rails'
- gem 'pry-byebug', group: :development
- gem 'font-awesome-sass', '~> 5.4.1'
- gem 'rails-i18n'
- gem 'dotenv-rails'
- gem 'slim-rails'
- gem 'html2slim'
- gem 'kaminari'
- gem 'pry-rails'
- gem 'dalli'
- gem 'bullet'

一旦メモ書きに使います・・・

### トークルーム

- 自身が他の友達をフォロー（友達追加）した時点でトークルームが作られる
- その時点ではタイトル部分には相手の名前が表示される
- もしタイトルを入力せず、複数ユーザーのトークルームを作ったならば、タイトル部分には参加しているユーザーの名前が表示される
- タイトルを入力してルームを作ったならば、参加している全員が見ているタイトルはその名前になる
- 検索の時はタイトルのあるトークルームの検索と、フォローしているユーザーの検索を行う
- 表示した後にクリックされればそのトークルーム、あるいはユーザーとのトークルームのトークindexを表示させる

- 知り合いかもには一旦自分以外のユーザーを表示
- 友だち追加した友だちを押すと右側にトークルームを表示トークを送ると同時にルームが作成される

### ユーザーエディット
- 名前とメッセージの部分はdivか何かで自分のステータスを表示、クリックされたらエディット部分に切り替え表示させる

### css
width: max-content;　要素の幅で合わせる　かなり沼


### 通話機能
skyway 使用
