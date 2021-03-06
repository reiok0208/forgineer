class HomeController < ApplicationController
  def top
    @diaries = Diary.all.order(id: 'DESC')
  end

  def info
    @inquiry = Inquiry.new
    @admin = User.find(1)
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.inquiry_mail(@inquiry).deliver
      flash[:notice] = 'お問い合わせを受け付けました'
      render :info
    else
      flash[:notice] = 'お問い合わせの送信に失敗しました'
      render :info
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :message)
  end
end
