# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview

  def inquiry
    inquiry = Inquiry.new(name: "テスト", message: "内容")

    InquiryMailer.inquiry_mail(inquiry)
  end

end
