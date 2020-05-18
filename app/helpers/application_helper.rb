module ApplicationHelper
  def display_header_name(user)
      "ようこそ、#{user.nickname}さん！"
  end
end
