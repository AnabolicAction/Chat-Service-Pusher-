class ChatRoom < ActiveRecord::Base
  #채팅 1:n
  has_many :chats
  #user M:N, admission
  has_many :users, through: :admissions
  has_many :admissions
  #생성하는 커밋이 발생할 때에만 밑에꺼 발생
  after_commit :create_chat_room_notification, on: :create
  after_commit :destroy_chat_room_notification, on: :destroy
  def create_chat_room_notification
    #Pusher.trigger(채널명,이벤트명,정보json)
    Pusher.trigger('chat_room', 'create',self.as_json)
  end
  def destroy_chat_room_notification
    Pusher.trigger('chat_room', 'destroy',self.as_json)
    Pusher.trigger("chat_room_#{self.id}",'destroy',{}) #데이터
  end
end
