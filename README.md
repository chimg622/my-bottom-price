# アプリケーション名
My-Bottom-Price


# アプリケーション概要
買い物の記憶をデジタル化して、目の前の商品が安いかどうか判断をするためのアプリ


# URL
https://my-bottom-price.onrender.com


# テスト用アカウント
・Basic認証ID：admin<br>
・Basic認証パスワード：2222<br>
・メールアドレス：abc@abc<br>
・パスワード：abc123


# 利用方法

## 店舗名、商品名の登録
１、トップページからアカウントの新規登録を行う<br>
２、ホーム画面中央やフッター部分から、お店一覧や商品一覧画面に遷移する<br>
３、それぞれ右上の追加ボタンから、新規登録を行う
[![Image from Gyazo](https://i.gyazo.com/559a4c6c030427178f609d7c879d586b.png)](https://gyazo.com/559a4c6c030427178f609d7c879d586b)
[![Image from Gyazo](https://i.gyazo.com/a4248a1ca5e9713b138f8650b8e2f996.png)](https://gyazo.com/a4248a1ca5e9713b138f8650b8e2f996)

## 商品価格登録
１、ホームページ中央ボタンやフッター部分から、価格登録画面に遷移する<br>
２、情報を入力して、保存する
[![Image from Gyazo](https://i.gyazo.com/dad651bc87436e2d67ea0d7434ee6a5d.png)](https://gyazo.com/dad651bc87436e2d67ea0d7434ee6a5d)

## 価格を比較する
１、商品一覧画面から、比較したい商品の「底値をチェック」というボタンから、商品価格比較画面に遷移する
[![Image from Gyazo](https://i.gyazo.com/ad3f75adc26e8b05d0fdf216f8ac869e.png)](https://gyazo.com/ad3f75adc26e8b05d0fdf216f8ac869e)


# アプリケーションを作成した背景
日常の買い物で感じたことがある「損をした」というちょっとした後悔を
個人の努力に頼らずITの力で解消することで、納得感を持って賢く買い物ができるように
商品価格が比較しやすいアプリを制作した。


# 要件定義
https://docs.google.com/spreadsheets/d/1POGpyz6hazbYhS2T-3qiS0QRPA5sAEMtTF9frXvn-rg/edit?usp=sharing


# 実装予定の機能
カテゴリーも個人で使いやすいように、登録編集機能を実装予定


# データベース設計
[![Image from Gyazo](https://i.gyazo.com/8f5e2949f32f72ccea5cd1665c4ec88e.png)](https://gyazo.com/8f5e2949f32f72ccea5cd1665c4ec88e)

## usersテーブル
|Column             |Type   |Options                  |
|-------------------|-------|-------------------------|
|email              |string |null: false, unique: true|
|encrypted_password |string |null: false,             |
|name               |string |null: false,             |

### Association
has_many :prices<br>
has_many :shops<br>
has_many :items<br>
has_many :categories

## pricesテーブル
|Column     |Type       |Options                        |
|-----------|-----------|-------------------------------|
|price      |integer    |null: false                    |
|quantity   |integer    |null: false                    |
|unit       |integer    |null: false, default: 0        |
|unit_price |decimal    |precision: 10, scale: 2        |
|user       |references |null: false, foreign_key: true |
|shop       |references |null: false, foreign_key: true |
|item       |references |null: false, foreign_key: true |

### Association
belongs_to :user<br>
belongs_to :shop<br>
belongs_to :item

## shopsテーブル
|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|name         |string     |null: false                    |
|address      |string     |null: true                     |
|user         |references |null: false, foreign_key: true |

### Association
belongs_to :user<br>
has_many :prices


## itemsテーブル
|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|name         |string     |null: false                    |
|unit         |integer    |null: false, default: 0        |
|user         |references |null: false, foreign_key: true |
|category     |references |null: false, foreign_key: true |

### Association
belongs_to :user<br>
belongs_to :category<br>
has_many :prices

## categoriesテーブル
|Column        |Type       |Options                         |
|--------------|-----------|--------------------------------|
|name          |string     |null: false                     |
|user          |references |null: false, foreign_key: true  |

### Association
has_many :items<br>
belongs_to :user


# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/26a6562668d19543c9df0d4a8ecb3eaa.png)](https://gyazo.com/26a6562668d19543c9df0d4a8ecb3eaa)


# 開発環境
・フロントエンド：HTML、CSS、JavaScript<br>
・バックエンド：Ruby、Ruby on Rails<br>
・データベース：MySQL（開発環境）/PostgreSQL（本番環境）<br>
・インフラ：Render<br>
・エディタ：VSCode


# ローカルでの動作方法
以下のコマンドを順に実行<br>
% git clone https://github.com/chimg622/my-bottom-price<br>
% cd my-bottom-price<br>
% bundle install<br>
% rails db create<br>
% rails db migrate


# 工夫したポイント
JavaScriptを使用して、商品価格と内容量を入力し単位を選択すると、
その単位にあった比較しやすい値段が表示されるようにした。
また、商品一覧画面でも100gramあたりの値段で商品価格比較ができるようにした。
そして、外出先での使用が前提となるため、スマホで操作しやすいUIにこだわった。


# 改善点
今はデータが少ないですが、データが増えた際、動作が重くならないように、
N＋1問題の徹底排除には、未だ改善点があると思う。
また、店先での入力をよりハードルを下げるために、バーコードスキャン機能などの実装が必要だと考えており、
QuaggaJSなどのライブラリの学習にも取り組もうと考えている。


# 制作時間
約2週間
