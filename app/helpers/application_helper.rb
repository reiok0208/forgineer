module ApplicationHelper

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

  #シンタックスハイライトのgem「coderay」
  require "redcarpet"
  require "coderay"
  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      case language.to_s
      when 'rb'
          lang = 'ruby'
      when 'yml'
          lang = 'yaml'
      when 'css'
          lang = 'css'
      when 'html'
          lang = 'html'
      when ''
          lang = 'md'
      else
          lang = language
      end
      CodeRay.scan(code, lang).div
    end
  end

  #マークダウンのgem「redcarpet」
  def markdown(text)
    html_render = HTMLwithCoderay.new(hard_wrap: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      xhtml: true,
      lax_html_blocks: true,
      strikethrough: true
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text).html_safe
  end
end
