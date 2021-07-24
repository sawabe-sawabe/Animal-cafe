class GroupBoardsController < ApplicationController
  before_action :authenticate_user!

   def create
     @group = Group.find(params[:group_id])
     @group_board_message = current_user.group_boards.new(message_params)
     @group_board_message.group_id = @group.id
     @group_board_message.user_id = current_user.id

     unless  @group_board_message.save #空白では投稿できないようにする
       render :show
     end

   end

   def destroy
     @group =Group.find(params[:group_id])
     @group_board_message = @group.group_boards.find(params[:id])
     @group_board_message.destroy
   end


 private

  def message_params
    params.require(:group_board).permit(:message)
  end

end
