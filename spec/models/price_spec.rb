require 'rails_helper'

RSpec.describe Price, type: :model do
  before do
    @price = FactoryBot.build(:price)
  end

  describe '価格新規登録' do
    context '新規登録できるとき' do
      it '必要な情報を適切に入力して「価格を保存する」ボタンを押すと価格が登録される' do
        expect(@price).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'priceが空では登録できない' do
        @price.price = ''
        @price.valid?
        expect(@price.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが0以下では登録できない' do
        @price.price = 0
        @price.valid?
        expect(@price.errors.full_messages).to include('Price must be greater than 0')
      end
      it 'priceが全角では登録できない' do
        @price.price = '１０００'
        @price.valid?
        expect(@price.errors.full_messages).to include('Price is not a number')
      end
      it 'quantityが空では登録できない' do
        @price.quantity = ''
        @price.valid?
        expect(@price.errors.full_messages).to include("Quantity can't be blank")
      end
      it 'quantityが0以下では登録できない' do
        @price.quantity = 0
        @price.valid?
        expect(@price.errors.full_messages).to include('Quantity must be greater than 0')
      end
      it 'quantityが全角では登録できない' do
        @price.quantity = '１０００'
        @price.valid?
        expect(@price.errors.full_messages).to include('Quantity is not a number')
      end
      it 'unitが空では登録できない' do
        @price.unit = nil
        @price.valid?
        expect(@price.errors.full_messages).to include("Unit can't be blank")
      end
      it 'unit_priceが空では登録できない' do
        @price.unit_price = ''
        @price.valid?
        expect(@price.errors.full_messages).to include("Unit price can't be blank")
      end
      it 'userが紐付いていないと登録できない' do
        @price.user = nil
        @price.valid?
        expect(@price.errors.full_messages).to include('User must exist')
      end
      it 'shopが紐付いていないと登録できない' do
        @price.shop = nil
        @price.valid?
        expect(@price.errors.full_messages).to include('Shop must exist')
      end
      it 'itemが紐付いていないと登録できない' do
        @price.item = nil
        @price.valid?
        expect(@price.errors.full_messages).to include('Item must exist')
      end
    end
  end
end
