module ApplicationHelper
  def display_header_name(user)
      "ようこそ、#{user.nickname}さん！"
  end

  # デバイスのエラーメッセージ出力メソッド
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    # エラーメッセージ用のHTMLを生成
    html += <<-EOF
        <div class="error_field alert alert-danger" role="alert" style="width:500px; margin:20px 0; padding:10px;">
      EOF
    messages = resource.errors.full_messages.each do |msg|
      html += <<-EOF
          <p class="error_msg">#{msg}</p>
      EOF
    end
    html += <<-EOF
        </div>
      EOF
    html.html_safe
  end
end
