require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品新規登録' do
    context '新規登録できるとき' do
      it '必要な情報を適切に入力して「商品を保存する」ボタンを押すと商品が登録される' do
        expect(@item).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'unitが空では登録できない' do
        @item.unit = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Unit can't be blank")
      end
      it 'userが紐付いていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'categoryが紐付いていないと登録できない' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must exist')
      end
    end
  end
end
