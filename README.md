## usersテーブル

|Column             |Type   |Options                  |
|-------------------|-------|-------------------------|
|email              |string |null: false, unique: true|
|encrypted_password |string |null: false,             |
|name               |string |null: false,             |

### Association
has_many :prices
has_many :shops
has_many :items
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
belongs_to :user
belongs_to :shop
belongs_to :item


## shopsテーブル
|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|name         |string     |null: false                    |
|address      |string     |null: true                     |
|user         |references |null: false, foreign_key: true |

### Association
belongs_to :user
has_many :prices


## itemsテーブル
|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|name         |string     |null: false                    |
|unit         |integer    |null: false, default: 0        |
|user         |references |null: false, foreign_key: true |
|category     |references |null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :category
has_many :prices


## categoriesテーブル
|Column        |Type       |Options                         |
|--------------|-----------|--------------------------------|
|name          |string     |null: false                     |
|user          |references |null: false, foreign_key: true  |

### Association
has_many :items
belongs_to :user
