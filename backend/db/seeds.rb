Faker::Config.locale = :en

User.create!(
  [
    {
      name: 'Tester',
      email: 'test@user.com',
      password: 'pass12345678',
      password_confirmation: 'pass12345678',
      image: File.open('./public/uploads/sample_images/user/1.jpg')
    },
    {
      name: 'Shuhei Nakada',
      email: 'develop@app.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/2.jpg')
    },
    {
      name: 'Hidehira Nakata',
      email: 'other@user.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/3.jpg')
    },
    {
      name: 'Satoshi Masara',
      email: 'monster@get.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/4.jpg')
    },
    {
      name: 'Takeshi Iwa',
      email: 'iwark@katai.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/5.jpg')
    },
    {
      name: 'Kasumi Mizube',
      email: 'star@me.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/6.jpg')
    },
    {
      name: 'Ponzu',
      email: 'bee@killer.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/7.jpg')
    },
    {
      name: 'Bisuke',
      email: 'bisket@muscle.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/8.png')
    },
    {
      name: 'Mito',
      email: 'obasan@kindness.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/9.jpg')
    },
    {
      name: 'Karuto',
      email: 'kimono@paper.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      image: File.open('./public/uploads/sample_images/user/10.jpg')
    }
  ]
)

25.times do |n|
  User.create(
    name: Faker::Name.unique.male_first_name,
    email: Faker::Internet.email,
    password: 'pass1234',
    password_confirmation: 'pass1234',
    image: File.open("./public/uploads/sample_images/user/#{n + 11}.jpg")
  )
end
25.times do |n|
  User.create(
    name: Faker::Name.unique.female_first_name,
    email: Faker::Internet.email,
    password: 'pass1234',
    password_confirmation: 'pass1234',
    image: File.open("./public/uploads/sample_images/user/#{n + 36}.jpg")
  )
end

Profile.create!(
  [
    {
      user_id: 1,
      status: '就職済み',
      birth: '2002/01/01',
      starting_age: '20-24歳',
      gender: '男性',
      residence: '東京都',
      introduction:
      'はじめまして。

      2020年4月からプログラミング学習を6ヶ月し、
      2020年12月に未経験からエンジニア転職しました。

      これまでの自分の学習記録も残しながら、
      勉強中の方とも繋がりたいな…と思い
      アカウントを作成しました。

      どうぞ宜しくです！',
      hobby: '筋トレ',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Nuxt, PHP, PostgreSQL, EC2, Docker, CodePipeline',
      study_period: 4,
      study_method: '独学',
      teaching_materials: 'menta',
      corporate_form: '自社開発',
      company_size: 10,
      annual_income: 400,
      entry: 50,
      meet: 30,
      accepted: 10
    },
    {
      user_id: 2,
      status: '学習中',
      birth: '1992/01/01',
      starting_age: '30-34歳',
      gender: '男性',
      residence: '大阪府',
      introduction:
      'はじめまして。

      私は前職は非IT業界で営業職でした。

      昨年6月から本格的にプログラミング学習を開始し、
      今年4月から就職活動をしております。

      未経験からの学習記録も当サイトに残していければ…と
      考えておりますので、宜しくお願いいたします。',
      hobby: '散歩',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Vue, TailwindCSS, Rails, MySQL, ECS/Fargate, Docker, CircleCI, Terraform',
      study_period: 10,
      study_method: '独学',
      teaching_materials: 'Udemy',
      corporate_form: '',
      company_size: '',
      annual_income: '',
      entry: '',
      meet: '',
      accepted: ''
    },
    {
      user_id: 3,
      status: '学習中',
      birth: '1992/01/01',
      starting_age: '30-34歳',
      gender: '男性',
      residence: '京都府',
      introduction: 'はじめまして...',
      hobby: '映画鑑賞',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Nuxt, Vuetify, Rails, MySQL, ECS/Fargate, GitHub Actions, Terraform',
      study_period: 4,
      study_method: '独学',
      teaching_materials: 'youtube',
      corporate_form: '',
      company_size: '',
      annual_income: '',
      entry: '',
      meet: '',
      accepted: ''
    },
    {
      user_id: 4,
      status: '就職活動中',
      birth: '1992/01/01',
      starting_age: '30-34歳',
      gender: '男性',
      residence: '神奈川県',
      introduction: 'はじめまして...',
      hobby: '読書',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Next, Firebase, ECS/Fargate, GitHub Actions, Terraform',
      study_period: 6,
      study_method: 'プログラミングスクール',
      teaching_materials: 'tecpit',
      corporate_form: '',
      company_size: '',
      annual_income: '',
      entry: 100,
      meet: 20,
      accepted: 5
    },
    {
      user_id: 5,
      status: '就職活動中',
      birth: '1982/01/01',
      starting_age: '40-44歳',
      gender: '男性',
      residence: '東京都',
      introduction: 'はじめまして...',
      hobby: '格闘技',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Rails, MySQL, EC2, CircleCI, Docker',
      study_period: 3,
      study_method: 'プログラミングスクール',
      teaching_materials: 'menta',
      corporate_form: '',
      company_size: '',
      annual_income: '',
      entry: 20,
      meet: 5,
      accepted: 3
    },
    {
      user_id: 6,
      status: '就職済み',
      birth: '2002/01/01',
      starting_age: '20-24歳',
      gender: '女性',
      residence: '東京都',
      introduction:
      'はじめまして！
      昨年2021年に就職できました！
      就職後の気付きもアウトプットしていきます。
      今後も宜しくお願いします！
      ',
      hobby: '買い物',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Go, React, GraphQL, TypeScript, Docker, ECS/Fargate',
      study_period: 6,
      study_method: 'プログラミングスクール',
      teaching_materials: 'menta',
      corporate_form: '自社開発',
      company_size: 10,
      annual_income: 350,
      entry: 50,
      meet: 15,
      accepted: 8
    },
    {
      user_id: 7,
      status: '就職済み',
      birth: '2002/01/01',
      starting_age: '20-24歳',
      gender: '女性',
      residence: '東京都',
      introduction: 'はじめまして...',
      hobby: '漫画',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Nuxt, Vuetify, Rails, MySQL, Docker, ECS/Fargate, Terraform, CircleCI',
      study_period: 6,
      study_method: 'プログラミングスクール',
      teaching_materials: 'kindle',
      corporate_form: '自社開発',
      company_size: 10,
      annual_income: 350,
      entry: 50,
      meet: 15,
      accepted: 8
    },
    {
      user_id: 8,
      status: '就職済み',
      birth: '2002/01/01',
      starting_age: '20-24歳',
      gender: '女性',
      residence: '東京都',
      introduction: 'はじめまして...',
      hobby: '海外旅行',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Nuxt, Vuetify, Rails, MySQL, Docker, ECS/Fargate, Terraform, CircleCI',
      study_period: 6,
      study_method: 'プログラミングスクール',
      teaching_materials: 'dotinstall',
      corporate_form: '自社開発',
      company_size: 10,
      annual_income: 350,
      entry: 50,
      meet: 15,
      accepted: 8
    },
    {
      user_id: 9,
      status: '就職済み',
      birth: '2002/01/01',
      starting_age: '20-24歳',
      gender: '女性',
      residence: '東京都',
      introduction: 'はじめまして...',
      hobby: 'ジョギング',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Nuxt, Vuetify, Rails, MySQL, Docker, ECS/Fargate, Terraform, CircleCI',
      study_period: 6,
      study_method: 'プログラミングスクール',
      teaching_materials: 'Progate',
      corporate_form: '自社開発',
      company_size: 10,
      annual_income: 350,
      entry: 50,
      meet: 15,
      accepted: 8
    },
    {
      user_id: 10,
      status: '就職済み',
      birth: '2002/01/01',
      starting_age: '20-24歳',
      gender: '女性',
      residence: '東京都',
      introduction: 'はじめまして...',
      hobby: 'ヨガ',
      github: 'https://github.com/',
      twitter: 'https://twitter.com/',
      qiita: 'https://qiita.com/',
      wontedly: 'https://www.wantedly.com/',
      technology_used: 'Nuxt, Vuetify, Rails, MySQL, Docker, ECS/Fargate, Terraform, CircleCI',
      study_period: 6,
      study_method: 'プログラミングスクール',
      teaching_materials: 'menta',
      corporate_form: '自社開発',
      company_size: 10,
      annual_income: 350,
      entry: 50,
      meet: 15,
      accepted: 8
    }
  ]
)

25.times do |n|
  Profile.create(
    user_id: n + 11,
    status: '学習中',
    birth: '1997/01/01',
    starting_age: '20-24歳',
    gender: '男性',
    residence: '東京都',
    introduction: 'はじめまして...',
    hobby: '買い物',
    github: 'https://github.com/',
    twitter: 'https://twitter.com/',
    qiita: 'https://qiita.com/',
    wontedly: 'https://www.wantedly.com/',
    technology_used: 'Nuxt, Vuetify, Rails, MySQL, Docker, ECS/Fargate, Terraform, CircleCI',
    study_period: 6,
    study_method: 'プログラミングスクール',
    teaching_materials: 'Udemy',
    corporate_form: '',
    company_size: '',
    annual_income: '',
    entry: '',
    meet: '',
    accepted: ''
  )
end
25.times do |n|
  Profile.create(
    user_id: n + 36,
    status: '学習中',
    birth: '1997/01/01',
    starting_age: '25-29歳',
    gender: '女性',
    residence: '大阪府',
    introduction: 'はじめまして...',
    hobby: '買い物',
    github: 'https://github.com/',
    twitter: 'https://twitter.com/',
    qiita: 'https://qiita.com/',
    wontedly: 'https://www.wantedly.com/',
    technology_used: 'Next, Rails, MySQL, Docker, ECS/Fargate, Terraform, CircleCI',
    study_period: 6,
    study_method: 'プログラミングスクール',
    teaching_materials: 'menta',
    corporate_form: '',
    company_size: '',
    annual_income: '',
    entry: '',
    meet: '',
    accepted: ''
  )
end

10.times do |n|
  Relationship.create!(
    [
      {
        follower_id: 1,
        followed_id: n + 2
      },
      {
        follower_id: n + 2,
        followed_id: 1
      }
    ]
  )
end
30.times do |n|
  Relationship.create!(
    [
      {
        follower_id: n + 3,
        followed_id: 2
      },
      {
        follower_id: n + 4,
        followed_id: 3
      }
    ]
  )
end
20.times do |n|
  Relationship.create!(
    [
      {
        follower_id: n + 5,
        followed_id: 4
      },
      {
        follower_id: n + 6,
        followed_id: 5
      }
    ]
  )
end

Article.create!(
  [
    {
      title: 'ローカルに開発環境を構築してインターネットにアプリを公開する',
      content:
      '
      Railsチュートリアルを完走後、まずはローカル環境構築をし、
      フレームワーク:Rails, データベース:MySQLとする構成のアプリを
      heroku上にホストし、インターネットに公開した経験を振り返る。

      初めて環境構築した時には、Rubyライブラリのインストールで依存関係の
      エラーメッセージに遭遇するなど謎が多く困り果てたインパクトが強い…

      Dockerを用いればベースとなるイメージに最低限必要なライブラリが揃った状態で
      個別に必要なパッケージを追加する形になるため、エラーも起きにくいだろう。
      （イメージのビルドが成功するまで何度もトライしたので、
      DockerはDockerで慣れるまで大変なのかも…）

      ひとまず、Railsチュートリアルで学んだものに付随して
      ・データベースをPostgreSQL→MySQLに変更
      ・cloud9ではなくローカルで環境構築する
      の２つを実現した。

      プログラミング学習は1つずつクリアしていくことで自信もついてくる。
      その一歩目がこの作業だったと思う。
      ',
      image: File.open('./public/uploads/sample_images/article/1.png'),
      user_id: User.first.id
    },
    {
      title: 'EC2内のデータベースに関わるパッケージ',
      content:
      '
      Railsアプリのホスト先をherokuからAWSのEC2に変更する時に
      MySQL関連のパッケージに触れたので記録しておく。

      EC2のAMI(AmazonMachineImage)でAmazonLinux２を選択した場合には
      デフォルトでMariaDBのパッケージがプレインストールされている。

      RDSでMySQLを選んでアプリケーションと通信したい場合は
      このMariaDBを削除しMySQLをインストールしなければならない。

      ただしOSバージョンに応じてMySQLパッケージも選ばないと
      エラーが発生するので注意しないといけない。

      具体例を挙げると
      「AmazonLinux２ならCentOS7系がベースなのでmysql80-community-release-el7-3.noarch.rpmのパッケージ」
      といったもの。

      https://dev.mysql.com/downloads/repo/yum/

      上記MySQLの公式ページにもOS何系か記載されているので判断材料にする。
      ',
      image: File.open('./public/uploads/sample_images/article/2.png'),
      user_id: User.first.id
    },
    {
      title: 'Dockerは起動が早くて便利',
      content:
      '
      これまで開発環境はローカルマシンに直接ライブラリなどをインストールしていたが
      Dockerのコンテナ環境を構築してみた。

      自分が導入後に感じたメリットは以下の通り。

      1、環境差異をなくせる
      ローカルマシンに手動で環境構築するとチーム内の開発者同士で
      どうしても環境差異が出てしまう。
      Dockerでは設定ファイルを同じ構成にすれば簡単に
      同じ環境が手に入るので、これが１番のメリットと言える。

      2、役割ごとにコンテナを整理できる
      基本原則でDockerは1コンテナ1役割とされている。
      そのため、Vue/ Nginx/ Rails/ MySQL といった責務に応じて
      コンテナを分けるのでデバッグなどの作業も問題箇所を切り分けられる。

      3、複数コンテナを一気に起動できる
      docker-composeという技術を用いれば、1コンテナずつ起動させるのではなく
      まとめて複数のコンテナを起動できるので無駄なコマンドを減らせる。

      4、起動が早い
      以前に仮想マシンVirtualBoxにも触ったことがあるが動作がかなり遅かった。
      それに比べると起動は高速!本当に早い!もう仮想マシンを使う必要はない。

      とにかく便利なので使いまくって設定に慣れるのが吉。
      ',
      image: File.open('./public/uploads/sample_images/article/3.png'),
      user_id: User.first.id
    },
    {
      title: 'フロントエンドのフレームワーク',
      content:
      'JavaScriptのフレームワークには、
      Vue/ React/ Nuxt/ Nextなど数多くあるが、
      私の場合は習得難易度で
      ポートフォリオにVue.jsを採用した。

      ただし、他のReactなどを書いたことがないので
      あくまでVueで開発した際の感覚値であるが
      感想を残そうと思う。

      率直な感想だけれども
      Railsのみで実装していた時よりも
      自分的にはかなり難しく苦しんだ…

      SPA? RailAPI? axios? VueRouter? Vuex?
      知らん用語が多くて何者か理解がムズイ。
      初学者にも関わらず、OptionsAPIではなく
      CompositionAPIの書き方に拘って
      文法に慣れるのに時間がかかる。
      ライフサイクルフックで
      コンポーネント起動順序で
      慣れないエラーに遭遇する。

      ただ、何度もコードを書いていくうちに
      こういったRailsAPIを作れば、
      Vueでこんなデータがこんな形で表現できる
      といった風に自分なりに開発に慣れてきた。

      後悔している事は、OptionsAPIも基礎学習したり
      難しいTypeScriptにも勉強時間を割いたり、
      かなり無駄な学習をしてしまった点。

      なので、今からポートフォリオを
      Vue.jsで実装していこうと考えている方は
      CompositonAPIをUdemyなどで学習し、
      その糖衣構文であるscript setupで
      書いていくと効率的に開発ができると思う。
      （TypeScriptはJSで完成してからの方が良い…）

      結局のところ、
      フレームワークはどれでもいいので
      早めに開発作業に入って苦しむのが吉かな。

      以上。独り言でした。
      ',
      image: File.open('./public/uploads/sample_images/article/4.png'),
      user_id: User.second.id
    },
    {
      title: 'CircleCIで自動ビルド・自動テストを実装する',
      content:
      '
      GitHub上に上がっているソースコードを引っ張ってきて
      それをビルドして実行ファイルにした後、
      rubocopでコード解析を走らせ、RSpecのテストもパスさせる。

      この一連の流れをCircleCIで実現できる。

      トリガーとなる「git push」コマンドをターミナル上で
      実行すれば、CircleCIがそれを検知して
      一連の処理を行うといったもの。

      自動化することで人為的なミスも防げるし、
      開発効率も上がるので大変ありがたい。
      ',
      image: File.open('./public/uploads/sample_images/article/5.png'),
      user_id: 6
    },
    {
      title: 'CircleCIでCI/CDパイプラインを完成させる',
      content:
      '
      前回のCI部分（自動ビルド・自動テスト）に続いて
      今回はCD部分（自動デプロイ）についても構築して
      CI/CDパイプラインを完成させた。

      具体的にはインフラにAWSを採用し、
      サービスの1つであるEC2に
      CircleCIを用いると自動でCapistranoが動作し
      デプロイされる仕組みを作れるということ。

      CIと同様に実行コマンドを手動で行う必要がなくなり、
      開発効率UPにつながるので、導入をお勧めする。
      ',
      image: File.open('./public/uploads/sample_images/article/6.png'),
      user_id: 6
    },
    {
      title: 'ECS/Fargateのデバッグ',
      content:
      '
      単純にAWSマネジメントコンソールのどこを見ればいいか
      分からず、訳が分からんかったので整理する。

      ■タスク起動前
      ECSの対象サービス画面のイベントのタブからメッセージを確認
      ■タスク起動後
      ECSの対象タスク画面にあるコンテナ名称を押してCloudWatchのログを表示
      （タスク＝コンテナが起動できていることが前提）

      ●コンテナにログインし中から検証する
      ECS Execを使用してDockerコンテナに入ったのちに
      logディレクトリなどを閲覧する

      確認する方法さえ分かってしまえばエラー原因が予測できる！

      私の場合はFargate上で起動しているコンテナに
      healthcheckが通らずタスク起動が
      うまくできないとう事象にぶち当たった。
      ',
      image: File.open('./public/uploads/sample_images/article/7.png'),
      user_id: 6
    },
    {
      title: 'EC2からECS/Fargateにホスト先を変更',
      content:
      '
      EC2にアプリをホストする事例はよくあるけど
      アンマネージドサービスのため、利用者側で
      OS更新など作業が発生し、運用コストがかかってしまう。

      またアクセス負荷に応じてコンテナ数を増やす
      スケーリング機能も設定が複雑らしい。

      上記2点を解決するのがECS/Fargateで運用する方法と言える。

      個人的には開発環境もコンテナ(Docker)で整えているので
      本番環境もDockerベースで構築できるのも嬉しい。

      簡単ではあるけどECS/Fargateの導入メリットして
      記録しておく。
      ',
      image: File.open('./public/uploads/sample_images/article/8.png'),
      user_id: 6
    },
    {
      title: 'CircleCI Orbを活用してシンプルに設定',
      content:
      '
      CircleCIのバージョン2.1を採用すれば
      Circle Orbをつかって、コードを簡略化できる。

      私の場合は、アプリのデプロイ先をECS/Fargate上にしているが
      それを実現するためには

      1、コンテナのイメージをECR（レジストリ）にプッシュする
      2、サービスを更新して同イメージを基とするタスク定義書でタスクを生成させる

      必要がある。

      これを手動ではなく、自動化させるためにCircleCIを用いるが
      さらにCircle Orbだとシンプルに設定ファイルがまとまるということ。

      というかネットで調べるとCircle Orbを使う実例が多いので
      自然とその記法をつかっている人が多いかも。

      以上。自分の頭を整理した内容でした。
      ',
      image: File.open('./public/uploads/sample_images/article/9.png'),
      user_id: 6
    },
    {
      title: 'Terraformでインフラをコード化',
      content:
      '
      AWSのマネジメントコンソール画面でボタンを押して
      インフラ構築するのはイメージがつきやすくて良い！

      一方で設定漏れなどの人為的なミスが生じやすい
      デメリットもある。

      IaSはインフラをコードで管理して
      コマンドを実行すること、設定コードをもとに
      自動的にインフラ構築を行ってくれる優れもの。

      TerraformはIaCの代表例として認知度が高く
      公式ドキュメントも分かりやすいのでお勧めできる。

      コマンドでインフラ作成もさることながら
      一括削除するコマンドもあり
      不要なリソースを消すことにも役立つ。

      そしてAWSリソースを理解して
      マネジメントコンソールからGUIで構築したことがある人なら
      あまり苦にならずに実装できるはず。

      転職活動ではTerraformを評価する企業も多かったので
      費用対効果が高い美味しい技術かもしれません。
      ',
      image: File.open('./public/uploads/sample_images/article/10.png'),
      user_id: User.third.id
    },
    {
      title: 'バックエンドにRails、フロントエンドにVueとする構成に分ける',
      content:
      '
      これまでMVCでいうところのV部分もRailsに任せていた。
      （RailsでMPA構成のアプリを作成していた）

      ただ最近はSPA構成のアプリケーションをよく見かけるので
      これを機にバックエンドとフロントエンドを
      それぞれ専門とするフレームワークに役割分担させようと思った。

      目標としては

      ・backend: Rails(APIモード)
      ・frontend: Vue

      といった具合にしたい。

      ということで開発環境から整えようとしたが
      RailsのみのDockerコンテナの開発環境では

      1、Rails
      2、MySQL

      の各コンテナを連携させる形だったが
      ここにVueをどうやって加えるんだ？
      と抽象的な問題が発生した。

      そこでSPA構成のアプリケーションについて
      自分なりに整理してみた。

      ・RailsはCRUD処理（作成・取得・更新・削除）のみに役割を専門化
      ・Vueは1つのindex.htmlの中身を動的に描画させる
      ・front/back間の連携はaxiosをいうパッケージを用いて
      HTTP通信を行い、ユーザーに応じたデータを表示させている

      ふむ、ということは
      「docker-composeでVueコンテナとRailsコンテナを同時起動させておいて
      クライアントが操作するVueコンテナにaxiosを設置して
      Rails側にリクエストを送れる形にすれば良いのか」
      と予想がたった。

      ひとまずイメージがついたので実装の具体例は調査しながら
      完成まで到達させたいと思う。

      では。
      ',
      image: File.open('./public/uploads/sample_images/article/11.png'),
      user_id: User.fourth.id
    },
    {
      title: 'フロントエンドVueのテスト',
      content:
      '
      backendのRailsではRSpecでテストコードを記述していた。

      frontendのVueはどうするの？

      公式のテストライブラリとして「Vue Test Utils」があるらしい。

      ただ、そもそもVueはフレームワークであって
      言語はJavaScriptになるから
      JavaScriptのテストフレームワークである「Jest」も
      同時に必要になるらしい。

      整理すると

      ・純粋なJavaScriptコードはJestだけでテストコードを書ける
      ・Vue特有のコンポーネントなどに関するテストは
      JestをベースにVueTestUtilsを活用してテストコードを書く

      ということかな？

      実際にテストを書きながら理解を深めていくことにしよう。
      ',
      image: File.open('./public/uploads/sample_images/article/12.png'),
      user_id: User.fifth.id
    },
    {
      title: 'デスク環境',
      content:
      '
      学習開始時はMacBookPro1つだったが、
      最終的にいろいろと買ってしまった。

      ・ディスプレイ（Dell）
      ・マウス（logicool: MX Master）
      ・キーボード（Topre: REALFORCE）
      ・PCスタンド（BoYataとtwelve south）
      ・マルチポートアダプター（Satechi）

      予算が見合うなら、早めに買っておいた方がいい。

      まずディスプレイは公式ドキュメントやQiita記事など
      参考資料を見ながらコーディングできた方が
      圧倒的に作業効率も上がるしストレスがない。
      （画面タブを切り替えてもいいが無意識にイラついてるはず。笑）

      マウスは2画面間の移動をスムーズにできる。
      MacBookのトラックパッドもMissionControlを起動する
      アクションを使いこなせば便利であるが
      ノートPC側にトラックパッドが付いているので
      やや使いにくい。

      キーボードも日本語配列より英字配列の方が
      プログラミングで多く使用する記号が押しやすい。
      さらにキーボードに応じて打鍵感も軽やかなものがあるので
      コードを書いていて気持ち良さを感じれ、自然に楽しさにつながる。

      PCスタンドはノートPCの目線を高くできるので
      疲れが生じにくい。安価なものも多いのでうれしい。

      以上。

      必須ではないけど使い始めたら
      ないと困る存在になるので、どうせ買うなら
      学習序盤で買っておいた方が良いかな…
      と個人的に思う次第である。
      ',
      image: File.open('./public/uploads/sample_images/article/13.jpg'),
      user_id: 7
    },
    {
      title: 'コードを打つことから離れる',
      content:
      '
      実装時に自分の予想とは異なり、
      何度もエラーにハマる時がある。

      そんな時は

      ・作業場所から離れて頭でふんわり考える
      ・ノートに書いて整理する
      ・いっそのこと異なる作業をしてみる

      などで問題解決できることがあった。

      一方で

      「エラー発生 → 原因予想 → 対処法調査 → 実行して検証」
      「異なるエラー → 違う原因を思いつく → 再び調査 → 検証」
      「さらに別のエラー ...」

      と次々に作業したくなる時は、
      無駄に間隔をあけず、集中して作業に没頭させて
      問題解決できる時もある。

      自分なりに解決しやすい方法を編み出すと
      楽しくプログラミングできるのでオススメです。
      ',
      image: File.open('./public/uploads/sample_images/article/14.jpg'),
      user_id: 7
    },
    {
      title: 'メンターの重要性',
      content:
      '
      個人的にプログラミングスクール・オンラインサロンで
      講師の方を頼った方が良いと思う。

      プログラミング学習する過程で、

      ・ポートフォリオに組み入れる技術はコレで大丈夫か？
      ・エラー発生時に自分だけでは時間がかかりそう…
      ・就職活動どう進めればいいんだ…

      など悩みはいろいろ出てくるのではないか。

      私の場合は、月額料金を払ってメンター契約をしている。

      正直なところ、質問回数としては月数回で多い方ではないが
      実務経験のあるエンジニアの方から

      ・開発時のコーディングのアドバイス
      ・エラー発生時の解決までのヒント
      ・web開発企業の知見
      etc...

      を聞けるのは十分メリットであり、こころの支えにもなった。

      完全独学でメンタル的にキツくなってきた人も
      検討してみる価値有りかと。

      それでは失礼。
      ',
      image: File.open('./public/uploads/sample_images/article/15.jpg'),
      user_id: 7
    }
  ]
)

ArticleTag.create!(
  [
    {
      tag_name: 'Ruby'
    },
    {
      tag_name: 'Rails'
    },
    {
      tag_name: 'rubocop'
    },
    {
      tag_name: 'RSpec'
    },
    {
      tag_name: '仮想マシン'
    },
    {
      tag_name: 'コンテナ'
    },
    {
      tag_name: 'Docker'
    },
    {
      tag_name: 'docker-compose'
    },
    {
      tag_name: 'VirtualBox'
    },
    {
      tag_name: 'JavaScript'
    },
    {
      tag_name: 'TypeScript'
    },
    {
      tag_name: 'Vue'
    },
    {
      tag_name: 'Nuxt'
    },
    {
      tag_name: 'React'
    },
    {
      tag_name: 'Next'
    },
    {
      tag_name: 'SPA'
    },
    {
      tag_name: 'axios'
    },
    {
      tag_name: 'VueRouter'
    },
    {
      tag_name: 'Vuex'
    },
    {
      tag_name: 'OptionsAPI'
    },
    {
      tag_name: 'CompositionAPI'
    },
    {
      tag_name: 'heroku'
    },
    {
      tag_name: 'AWS'
    },
    {
      tag_name: 'EC2'
    },
    {
      tag_name: 'AMI'
    },
    {
      tag_name: 'ECS/Fargate'
    },
    {
      tag_name: 'CloudWatch'
    },
    {
      tag_name: 'ECS/EC2'
    },
    {
      tag_name: 'Route53'
    },
    {
      tag_name: 'cloudfront'
    },
    {
      tag_name: 'ELB'
    },
    {
      tag_name: 'ALB'
    },
    {
      tag_name: 'healthcheck'
    },
    {
      tag_name: 'CircleCI'
    },
    {
      tag_name: 'CircleCI Orb'
    },
    {
      tag_name: 'Capistrano'
    },
    {
      tag_name: 'Git'
    },
    {
      tag_name: 'GitHub'
    },
    {
      tag_name: 'ESLint'
    },
    {
      tag_name: 'prettier'
    },
    {
      tag_name: 'HTML'
    },
    {
      tag_name: 'CSS'
    },
    {
      tag_name: 'TailwindCSS'
    },
    {
      tag_name: 'Linux'
    },
    {
      tag_name: 'CentOS'
    },
    {
      tag_name: 'MySQL'
    },
    {
      tag_name: 'PostgreSQL'
    },
    {
      tag_name: 'SQLite'
    },
    {
      tag_name: 'Terraform'
    },
    {
      tag_name: 'IaC'
    },
    {
      tag_name: 'AWSマネジメントコンソール'
    },
    {
      tag_name: 'Jest'
    },
    {
      tag_name: 'VueTestUtils'
    },
    {
      tag_name: 'ディスプレイ'
    },
    {
      tag_name: 'マウス'
    },
    {
      tag_name: 'キーボード'
    },
    {
      tag_name: 'PCスタンド'
    },
    {
      tag_name: 'エラー'
    },
    {
      tag_name: '解決法'
    },
    {
      tag_name: '整理'
    },
    {
      tag_name: 'メンタリングサービス'
    }
  ]
)

ArticleTagmap.create!(
  [
    {
      article_id: 1,
      article_tag_id: 2
    },
    {
      article_id: 1,
      article_tag_id: 46
    },
    {
      article_id: 1,
      article_tag_id: 22
    },
    {
      article_id: 2,
      article_tag_id: 24
    },
    {
      article_id: 2,
      article_tag_id: 25
    },
    {
      article_id: 2,
      article_tag_id: 46
    },
    {
      article_id: 3,
      article_tag_id: 7
    },
    {
      article_id: 3,
      article_tag_id: 8
    },
    {
      article_id: 3,
      article_tag_id: 6
    },
    {
      article_id: 4,
      article_tag_id: 10
    },
    {
      article_id: 4,
      article_tag_id: 12
    },
    {
      article_id: 4,
      article_tag_id: 13
    },
    {
      article_id: 4,
      article_tag_id: 14
    },
    {
      article_id: 4,
      article_tag_id: 15
    },
    {
      article_id: 4,
      article_tag_id: 16
    },
    {
      article_id: 4,
      article_tag_id: 17
    },
    {
      article_id: 4,
      article_tag_id: 18
    },
    {
      article_id: 4,
      article_tag_id: 19
    },
    {
      article_id: 4,
      article_tag_id: 20
    },
    {
      article_id: 4,
      article_tag_id: 21
    },
    {
      article_id: 5,
      article_tag_id: 34
    },
    {
      article_id: 5,
      article_tag_id: 3
    },
    {
      article_id: 5,
      article_tag_id: 4
    },
    {
      article_id: 6,
      article_tag_id: 34
    },
    {
      article_id: 6,
      article_tag_id: 24
    },
    {
      article_id: 6,
      article_tag_id: 36
    },
    {
      article_id: 7,
      article_tag_id: 26
    },
    {
      article_id: 7,
      article_tag_id: 27
    },
    {
      article_id: 7,
      article_tag_id: 33
    },
    {
      article_id: 8,
      article_tag_id: 24
    },
    {
      article_id: 8,
      article_tag_id: 26
    },
    {
      article_id: 8,
      article_tag_id: 7
    },
    {
      article_id: 9,
      article_tag_id: 34
    },
    {
      article_id: 9,
      article_tag_id: 35
    },
    {
      article_id: 9,
      article_tag_id: 26
    },
    {
      article_id: 10,
      article_tag_id: 49
    },
    {
      article_id: 10,
      article_tag_id: 50
    },
    {
      article_id: 10,
      article_tag_id: 51
    },
    {
      article_id: 11,
      article_tag_id: 2
    },
    {
      article_id: 11,
      article_tag_id: 12
    },
    {
      article_id: 11,
      article_tag_id: 8
    },
    {
      article_id: 11,
      article_tag_id: 46
    },
    {
      article_id: 11,
      article_tag_id: 16
    },
    {
      article_id: 12,
      article_tag_id: 12
    },
    {
      article_id: 12,
      article_tag_id: 52
    },
    {
      article_id: 12,
      article_tag_id: 53
    },
    {
      article_id: 13,
      article_tag_id: 54
    },
    {
      article_id: 13,
      article_tag_id: 55
    },
    {
      article_id: 13,
      article_tag_id: 56
    },
    {
      article_id: 13,
      article_tag_id: 57
    },
    {
      article_id: 14,
      article_tag_id: 58
    },
    {
      article_id: 14,
      article_tag_id: 59
    },
    {
      article_id: 14,
      article_tag_id: 60
    },
    {
      article_id: 15,
      article_tag_id: 61
    }
  ]
)

10.times do |n|
  Like.create(
    [
      {
        article_id: n + 4,
        user_id: 1
      },
      {
        article_id: 1,
        user_id: n + 2
      },
      {
        article_id: 2,
        user_id: n + 3
      },
      {
        article_id: 3,
        user_id: n + 4
      },
      {
        article_id: 4,
        user_id: n + 5
      },
      {
        article_id: 5,
        user_id: n + 6
      }
    ]
  )
end

20.times do |n|
  Like.create(
    [
      {
        article_id: 6,
        user_id: n + 7
      },
      {
        article_id: 7,
        user_id: n + 7
      },
      {
        article_id: 8,
        user_id: n + 7
      }
    ]
  )
end

5.times do
  Room.create
end

Entry.create(
  [
    {
      user_id: 1,
      room_id: 1
    },
    {
      user_id: 2,
      room_id: 1
    }
  ]
)
Entry.create(
  [
    {
      user_id: 2,
      room_id: 2
    },
    {
      user_id: 3,
      room_id: 2
    }
  ]
)
Entry.create(
  [
    {
      user_id: 3,
      room_id: 3
    },
    {
      user_id: 4,
      room_id: 3
    }
  ]
)
Entry.create(
  [
    {
      user_id: 1,
      room_id: 4
    },
    {
      user_id: 3,
      room_id: 4
    }
  ]
)
Entry.create(
  [
    {
      user_id: 1,
      room_id: 5
    },
    {
      user_id: 4,
      room_id: 5
    }
  ]
)

Message.create(
  [
    {
      user_id: 2,
      room_id: 1,
      content:
      'こんにちは。
      自社開発企業で人事をしております中田と申します。
      自社開発企業の中でも、
      どういった業界への転職を目指されていますか？'
    },
    {
      user_id: 2,
      room_id: 1,
      content:
      '弊社で不動産売買に関わる契約行為を
      IT技術でサポートしております。
      ご興味があればフランクな形で
      面会も可能ですのでおっしゃってくださいね。'
    },
    {
      user_id: 2,
      room_id: 1,
      content:
      'なお、こちらに会社概要を載せておりますので
      宜しければご覧ください。

      https://homecresit.com'
    },
    {
      user_id: 1,
      room_id: 1,
      content:
      'ぜひお話を伺ってみたいです！
      前々職ではありますが、
      不動産関係の仕事をしておりました。'
    },
    {
      user_id: 1,
      room_id: 1,
      content:
      '従事していたのは売買ではなく賃貸ですが、
      不動産契約における
      非効率性・不真実性を感じておりました。'
    },
    {
      user_id: 1,
      room_id: 1,
      content:
      '中田さんは、
      いつでしたらお時間に余裕が
      ありますでしょうか？'
    },
    {
      user_id: 2,
      room_id: 1,
      content:
      '早速ご返信ありがとうございます。
      3月9日午前であれば弊社内のブースで
      お時間が確保できますが、
      いかがでしょうか？'
    },
    {
      user_id: 1,
      room_id: 1,
      content:
      'ぜひ、宜しくお願いします。

      では10時でいかがでしょうか？

      履歴書、職務経歴書を用意して訪問させて頂きます。'
    },
    {
      user_id: 2,
      room_id: 1,
      content:
      'かしこまりました。
      当日楽しみにしています。
      よろしくお願いします。'
    },
    {
      user_id: 3,
      room_id: 4,
      content:
      'はじめまして。最近勉強を始めた者です。
      私も転職が目標なんですが、
      プログラミング言語はどういった基準で
      選ばれましたでしょうか？'
    },
    {
      user_id: 3,
      room_id: 4,
      content:
      'ポートフォリオを拝見して
      未経験からハイクオリティなものを作成されていて
      驚いたのですが、
      今後の学習の参考にしたく質問させて頂きました。'
    },
    {
      user_id: 4,
      room_id: 5,
      content:
      'こんにちは。
      現在、就活中の者です。
      私はポートフォリオにあまり時間をかけずに
      就活を先行したのですが、書類通過率が悪いと感じており、
      ポートフォリオのブラッシュアップをしようと考えています。'
    },
    {
      user_id: 4,
      room_id: 5,
      content:
      '今はRailsのみでバックエンドもフロントエンドも
      記述しているのですが、
      VueやReactにフロントを任せて
      切り分けしようかと考えています。'
    },
    {
      user_id: 4,
      room_id: 5,
      content:
      '自己紹介を拝見したのですが、
      同じ工程を踏まれていると思いますが、
      Vueでコード記述までに
      どれくらい期間を要しましたでしょうか？
      ぜひお伺いしたいです！'
    }
  ]
)

Notification.create(
  visitor_id: 2,
  visited_id: 1,
  room_id: 1,
  message_id: 9,
  action: 'dm',
  checked: false
)
Notification.create(
  visitor_id: 2,
  visited_id: 1,
  room_id: 1,
  message_id: 1,
  action: 'dm',
  checked: true
)
2.times do |n|
  Notification.create(
    visitor_id: 3,
    visited_id: 1,
    room_id: 4,
    message_id: n + 10,
    action: 'dm',
    checked: false
  )
end
3.times do |n|
  Notification.create(
    visitor_id: 4,
    visited_id: 1,
    room_id: 5,
    message_id: n + 12,
    action: 'dm',
    checked: false
  )
end
