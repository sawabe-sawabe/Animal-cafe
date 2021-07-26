require 'rails_helper'

RSpec.describe 'PostImageモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    subject { post_image.valid? }

    let!(:user) { create(:user) }
    let!(:genre) { create(:genre) }
    let!(:post_image) { build(:post_image, user_id: user.id,genre_id: genre.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post_image.title = ''
        is_expected.to eq false
      end
    end

    context 'captionカラム' do
      it '空欄でないこと' do
        post_image.caption = ''
        is_expected.to eq false
      end
    end
 end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostImage.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'genreモデルとの関係' do
      it 'N:1となっている' do
        expect(PostImage.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
  end
end