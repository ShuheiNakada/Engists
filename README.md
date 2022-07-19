# 概要

* アプリ名: Engists
* サービス内容: エンジニア転職のサポートする情報サイト
* 対象: プログラミング学習中・転職活動中の人、内定者

https://www.engists.com/

<br>

# Engists

ネーミングはEngineをもったヒトを表したくて造語で表現しました。  
挫折せずにエンジンを動かし続ける、そんなイメージです。



<br>

# 作成した背景

エンジニア転職を支えるプログラミングスクールやオンラインサロンが増えてきたので  
1コミュニティではなく、初学者同士で情報共有できるwebサービスがあると面白いのでは…と考え、  
このテーマに決めました。　　

<br>

このアプリは、以下の問題解決を目的にしています　　
* 他者が転職を成功させるまでの記録を閲覧して、自己学習に活かす
* 同じ境遇の人に相談できる為、メンタル面を支えられる
* 企業に就職する駆け出しエンジニアのスキルを底上げ



<br>

# 使用技術　　

- フロントエンド
    - HTML / CSS / TailwindCSS / JavaScript / Vue.js 
- バックエンド
    - Ruby / Rails
- データベース
    - MySQL
- インフラ
    - AWS(VPC / ECS / ECR / CodeDeploy / ALB /  CloudFront / ACM / Route53 / RDS / S3 / IAM / SystemsManager)
    - Nginx / puma
    - Terraform
- テスト
    - RSpec / VueTestUtils
- CI/CD
    - CircleCI
- バージョン管理
    - Git / GitHub
- 開発環境
    - docker / docker-compose



<br>

# ER図
UsersモデルとProfilesモデルは1対1で関連付けしています。  
理由はRailsのGem「devise-token-auth」に認証機能を実装しており、  
それによって認証関連のカラムが多くなっている為、下記のように区別しました。  

* Usersモデル: 認証
* Profilesモデル: ユーザー属性

<br>


![engists_Diagram-Page-1 drawio](https://user-images.githubusercontent.com/83897526/163775948-30e7b502-1f8f-4476-882e-f6ceb5bea74b.png)



<br>

# インフラ図
サーバーレスの技術にも触れてみたく、  
ECS/Fargateのblue/green deploymentでデプロイしています。  
また、GUI操作のインフラ構築ではミスが生じやすいので  
コードから構築するTerraformも導入しました。  

<br>


<img width="1365" alt="インフラ図 2022-05-14" src="https://user-images.githubusercontent.com/83897526/168422125-4d860a2b-9e07-459e-a5ca-f52d73fe9d9b.png">



<br>

# 機能一覧  

* ユーザー新規登録/ログイン
* 簡単ログイン
* ユーザー情報編集
* ダーク/ライトモード切り替え
* 検索（性別/年齢/地域/ステータス）
* ソート（作成日・更新日/フォロワー数/いいね数）
* ダイレクトメッセージ
* フォロー/フォロー解除
* 記事投稿/編集
* コメント
* フォロワー/いいねした記事/自分で投稿した記事の一覧表示
* 通知（DM受信で件数をオレンジ色で表示）
* 画像アップロード機能(ユーザーアイコン・記事イメージ)



<br>

# 操作方法
それぞれgif画像でデモしていますので、参考にしてください。  

<br>


## テストユーザーでログインする
テストユーザーの場合は、ユーザー情報を編集できない仕様としています。

![loginAsTestUser (1)](https://user-images.githubusercontent.com/83897526/162597191-cbc35ff4-a1e6-4c7f-b8dc-d6d73d0a4bbb.gif)

<br>


## レスポンシブデザイン(モバイルファースト)
出来るだけスマフォでも見られるようにUI/UXを整えています。

![responsive](https://user-images.githubusercontent.com/83897526/162610507-d1f2e1dc-3809-4cc6-a807-1f3cc8e27da2.gif)

<br>


## ダークモード・ライトモード切り替え
目に負担のかからないダークモードを搭載しました。  
スイッチで切り替え可能ですが、ページを更新すると元に戻ります。  
（OS設定に依存させています。）　　

![switch_dark_light](https://user-images.githubusercontent.com/83897526/162613144-bbcceed8-8d83-47b0-a4ba-6053be8613db.gif)

<br>


## ユーザーを検索する
ユーザー検索には自分と似た境遇の人を見つけ出すために検索条件を指定します。  
部分一致と完全一致がありますので、使い分けて使用してください。  
（フォロワー数の多い順にソートもできます）  

![search_for_users](https://user-images.githubusercontent.com/83897526/162610468-71a092ea-3fc9-4701-8dc6-b1cf038e4e84.gif)

<br>


## 投稿記事を検索する
記事検索はキーワードで検索できます。  
タイトルまたは記事本文にキーワードが含まれていれば検索結果に表示されます。  
(いいね数の多い順にソートもできます)  

![search_for_articles](https://user-images.githubusercontent.com/83897526/162610486-2fccaa4b-0ab4-458b-8858-e93c2b169d2d.gif)

<br>

## ランキング
フォロワー数の多いユーザー、いいね数の多い投稿をランキングしています。  
左から順位付けしており、横スクロールできます。  

![ranking](https://user-images.githubusercontent.com/83897526/162643269-baaf33f2-4cf3-4d01-b558-8bb5c86ac731.gif)

<br>


## 記事を投稿する
タグの複数入力は半角の空白をいれれば対応可能です。

![post_article](https://user-images.githubusercontent.com/83897526/162611044-068281f8-060d-43c7-b074-42b96af11817.gif)

<br>


## DMを送信する
相談してみたいユーザーが見つかれば、直接DMを送信できます。

![send_dm](https://user-images.githubusercontent.com/83897526/162613133-f594a3f0-8864-49dd-9fc7-068d1bfe44aa.gif)

<br>


## 通知機能
未読のDMがあった場合には、ナビゲーションバーのアイコンがオレンジ色に変わり、未読件数が表示されます。  
DMルームに入室後、未読ボタンを押せば既読に切り替わり未読件数も減少します。  

![notification_dm](https://user-images.githubusercontent.com/83897526/162613110-417363a5-df39-40da-a87a-2902ed78fa34.gif)

<br>


## マイページ
ユーザー名/ メールアドレス/ パスワードの基本情報、および　  
その他のプロフィール項目が編集できます。  
（テストユーザーは編集できないので、ご留意ください。）  

![profile_update](https://user-images.githubusercontent.com/83897526/162613125-2fd7b27d-2491-44c3-82c0-10758fb77e30.gif)

<br>


## 記事に画像を投稿する
投稿記事に参考になるイメージ画像を添付できます。  
タブレット及びPCはドラッグ＆ドロップでファイルをアップロードできます。

![post_an_image](https://user-images.githubusercontent.com/83897526/168421548-badc2ea9-56a2-485f-ae07-a1e61697d8b9.gif)

<br>


## ユーザーアイコンを設定する
プロフィール画面からユーザーのアイコンを設定できます。  
同様にドラッグ＆ドロップでファイルをアップロードする機能をつけています。

![set_user_icon](https://user-images.githubusercontent.com/83897526/168421560-3bd219d1-6486-45da-91e6-becdc04823de.gif)

<br>


## リスト表示
フォローユーザー/ いいねした記事/ 自分で投稿した記事を  
それぞれリスト表示で確認できます。

![show_list](https://user-images.githubusercontent.com/83897526/162613136-7d040867-b69a-46ed-8d86-73b7d158a161.gif)

<br>
