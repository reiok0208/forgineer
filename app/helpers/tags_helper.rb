module TagsHelper
  def tag_dup_valid(value)
    cut_full_width = value.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z') #全角英数字を半角英数字に
    space_delete = cut_full_width.gsub(/ |　/){""} #全ての半角全角スペースを消す
    space_delete.downcase #重複検証のため全て小文字に変換
  end
end
