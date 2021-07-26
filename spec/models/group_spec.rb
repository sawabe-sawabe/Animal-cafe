require 'rails_helper'

RSpec.describe 'Groupモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { group.valid? }

    let!(:other_group) { create(:group) }
    let!(:user) { build_stubbed(:user, :user_with_groups) }
    let(:group) { build_stubbed(:group) }



    context 'introductionカラム' do
      it '空欄でないこと' do
        group.introduction = ''
        is_expected.to eq false
      end
    end
    context 'nameカラム' do
      it '空欄でないこと' do
        group.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        group.name = other_group.name
        is_expected.to eq false
      end
    end
     context 'wordカラム' do
      it '30文字以下であること: 30文字は〇' do
        group.word = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '31文字以下であること: 31文字は×' do
        group.word = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:users).macro).to eq :has_many
      end
    end
   context 'group_usersモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:group_users).macro).to eq :has_many
      end
    end

  end
end