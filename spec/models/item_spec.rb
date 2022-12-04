require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/star.png')
  end

  describe '出品機能' do
    context '出品ができる時' do
      it '必須項目が全てあれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '出品ができない時' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image.key = ''
        @item.valid?
        expect(@item.errors.full_messages).to include { "Image can't be blank" }
      end

      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品の状態についての情報が必須であること' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status Select')
      end

      it '配送料の負担についての情報が必須であること' do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee status Select')
      end

      it '発送元の地域についての情報が必須であること' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end

      it '発送までの日数についての情報が必須であること' do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery Select')
      end

      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '販売価格は、¥300未満では出品できない' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '販売価格は、¥9,999,999を超えると出品できない' do
        @item.price = '99,999,999'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it '発送までの日数が未選択だったら出品できない' do
        @item.scheduled_delivery_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery Select')
      end

      it '発送元の地域が未選択だったら出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end

      it '配送料の負担が未選択だったら出品できない' do
        @item.shipping_fee_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee status Select')
      end

      it '商品の状態が未選択だったら出品できない' do
        @item.sales_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status Select')
      end

      it 'カテゴリーが未選択だったら出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
