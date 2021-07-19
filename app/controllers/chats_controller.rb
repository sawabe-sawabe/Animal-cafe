class ChatsController < ApplicationController
  before_action :follow_each_other, only: [:show] #相互フォローしているユーザーのみDMできるようにする
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id) #現在のユーザーのuser_room のroom_idの値のみをを取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil? #既にroomが存在しているかを確認し、なければ新規作成する
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats.order('created_at DESC') #最新の情報が上に来るように並び替え
    @chat = Chat.new(room_id: @room.id)
  end
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
     redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def follow_each_other #相互フォローしているユーザーのみDMできるようにする
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user)
    end
  end
 end

