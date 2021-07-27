require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    let!(:other_genre) { create(:genre) }
    let(:genre) { build(:genre) }

    context 'nameカラム' do
      it '空欄でないこと' do
        genre.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        genre.name = other_genre.name
        is_expected.to eq false
      end

      it '20文字以下であること: 20文字は〇' do
        genre.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        genre.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'post_imageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
  end
end
