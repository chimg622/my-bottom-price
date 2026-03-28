require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @shop = FactoryBot.build(:shop)
  end

  describe '店舗新規登録' do
    context '新規登録できるとき' do
      it '必要な情報を適切に入力して「店舗を保存する」ボタンを押すと店舗が登録される' do
        expect(@shop).to be_valid
      end
      it 'addressが空でも登録できる' do
        @shop.address = ''
        expect(@shop).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @shop.name = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが30文字以上では登録できない' do
        @shop.name = Faker::Lorem.characters(number: 31)
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Name is too long (maximum is 30 characters)')
      end
      it '同じユーザーで重複したnameが存在する場合は登録できない' do
        @shop.save
        another_shop = FactoryBot.build(:shop, name: @shop.name, user: @shop.user)
        another_shop.valid?
        expect(another_shop.errors.full_messages).to include('Name は既に登録されています')
      end
      it '別のユーザーであれば重複したnameが存在しても登録できる' do
        @shop.save
        another_shop = FactoryBot.build(:shop, name: @shop.name)
        expect(another_shop).to be_valid
      end
      it 'userが紐付いていないと登録できない' do
        @shop.user = nil
        @shop.valid?
        expect(@shop.errors.full_messages).to include('User must exist')
      end
    end
  end
end
