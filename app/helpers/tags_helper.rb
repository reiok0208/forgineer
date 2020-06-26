module TagsHelper
  def replace(value)
    value.gsub(/　|ㅤ/){" "}.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')
    #受け取った名前の全角英数字を半角英数字に変換、全角空白「　」(%E3%80%80)と特殊空白文字「ㅤ」（%E3%85%A4）を「 」(%20)へ変換
  end

  def tag_dup_valid(value)
    tag_space_delete = value.gsub(/ /){""} #全ての半角スペースを消す
    tag_downcase = tag_space_delete.downcase #重複検証のため全て小文字に変換
  end
end
