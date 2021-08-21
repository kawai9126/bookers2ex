class ChatsController < ApplicationController
    def show
        @user = User.find(params[:id])
        #currentuserのuser_roomにあるroom_idの値をplunkで配列にしてroomsに代入。
        rooms = current_user.user_rooms.pluck(:room_id)
        # user_idがチャット相手のidが一致するものと、room_idが上記roomsのどれかに一致するレコードをuser_roomsに入れる。
        user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
        # もしuser_roomが空じゃない時
        unless user_rooms.nil?
            #　@roomにuser_roomのroomを入れる。
            @room = user_rooms.room
        else
            @room = Room.new
            @room.save
            #　空ならば作りuser_roomをカレントユーザー分とチャット相手分を作る。
            UserRoom.create(user_id: current_user.id, room_id: @room.id)
            UserRoom.create(user_id: @user.id, room_id: @room.id)
        end
        @chats = @room.chats
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
end
