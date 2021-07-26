require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'wordカラム' do
      it '30文字以下であること: 30文字は〇' do
        user.word= Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字以下であること: 31文字は×' do
        user.word = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'post_imageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
    context 'group_userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:group_users).macro).to eq :has_many
      end
    end

  end
end