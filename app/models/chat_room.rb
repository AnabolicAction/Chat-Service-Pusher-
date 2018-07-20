class ChatRoom < ActiveRecord::Base
  #채팅 1:n
  has_many :chats
  #user M:N, admission
  has_many :usersm through: :admissions
  has_many :admissions
end
