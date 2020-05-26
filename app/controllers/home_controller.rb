class HomeController < ApplicationController
  def top
  end

  def info
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.inquiry_mail(@inquiry).deliver
      flash[:notice] = 'お問い合わせを受け付けました'
      redirect_to home_info_path
    else
      flash[:notice] = 'お問い合わせの送信に失敗しました'
      redirect_to home_info_path
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :message)
  end
end
