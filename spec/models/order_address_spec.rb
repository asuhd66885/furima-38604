require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '購入機能' do
    context '購入できる場合' do
      it '必須項目全てがあれば購入できる' do
        expect(@order_address).to be_valid
      end

      it '建物項目が未記入でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が空だと購入出来ない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { "Postal code can't be blank" }
      end

      it '郵便番号は3桁ハイフン4桁の半角文字列ではないと購入出来ない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { 'Postal code is invalid' }
      end

      it '都道府県が空だと購入出来ない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { "Prefecture id code can't be blank" }
      end

      it ' 市区町村が空だと購入出来ない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { "City can't be blank" }
      end

      it ' 番地が空だと購入出来ない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { "Address can't be blank" }
      end

      it ' 電話番号が空だと購入出来ない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { "Phone number can't be blank" }
      end

      it ' 電話番号は10桁以上11桁以内の半角数値のみではないと購入できない' do
        @order_address.phone_number = '090-1234-4554'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { 'Phone number is invalid' }
      end

      it ' 電話番号は12桁以上の半角数値だと購入できない' do
        @order_address.phone_number = '32145676543'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { 'Phone number is invalid' }
      end

      it ' 電話番号は 9桁以下の半角数値だと購入できない' do
        @order_address.phone_number = '574869504'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { 'Phone number is invalid' }
      end

      it ' トークン空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include { 'Token is invalid' }
      end

      it 'userが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it '発送元の地域が未選択だったら購入できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
    end
  end
end
