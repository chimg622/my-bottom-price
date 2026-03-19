# 既存のデータをリセット（二重登録を防ぐ）
Category.destroy_all

# 現在ログインしてテストするユーザーを特定（いなければ作成）
user = User.first || User.create!(name: "テストユーザー", email: "test@example.com", password: "password")

# カテゴリデータの配列
category_names = ["野菜・果物", "肉・魚", "飲料・お酒", "日用品・洗剤", "菓子・アイス", "調味料", "その他"]

# 一括登録
category_names.each do |name|
  Category.create!(name: name, user_id: user.id)
end

puts "--- カテゴリの初期データを #{Category.count} 件登録しました！ ---"
