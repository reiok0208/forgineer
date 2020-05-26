class InquiryMailer < ApplicationMailer
  def inquiry_mail(inquiry)
    name = ENV['GOOGLE_MAIL_NAME']
    @inquiry = inquiry
    mail(
      from: 'system@example.com',
      to:   name,
      subject: 'Forgineerユーザーから問い合わせ'
    )
  end
end
