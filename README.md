devmates
========

developing tools for me

doron
-----

- 概要

gitユーザーの情報を素早く変更する．


- インストール

bin/doronをC:\usr\local\binに配置する．
bin/doron.batをパスの通ったディレクトリに配置する．

- 設定

bin/doronの最後の部分に
```
cmd:
  name: user_name
  email: mail_address
```
の形式でユーザー名・メールアドレスを書く．
cmdの部分も好きなように分かりやすいものを書いてください．

- 使い方

上のようなインストール・設定が終わったら，コマンドプロンプトなどから
`doron cmd`
とコマンドを打つと、その設定になる．

`git config -l`
でどのようになったかが分かるでしょう．
