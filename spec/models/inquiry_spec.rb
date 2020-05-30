require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe "バリデーションに関するテスト" do
    it "名前がなければ無効な状態であること" do
      inquiry = Inquiry.new(name: nil)
      inquiry.valid?
      expect(inquiry.errors[:name]).to include("を入力してください")
    end

    it "名前が10文字以上であれば無効な状態であること" do
      inquiry = Inquiry.new(name: "t" * 20)
      inquiry.valid?
      expect(inquiry.errors[:name]).to include("は10文字以内で入力してください")
    end

    it "内容がなければ無効な状態であること" do
      inquiry = Inquiry.new(message: nil)
      inquiry.valid?
      expect(inquiry.errors[:message]).to include("を入力してください")
    end
  end
end
