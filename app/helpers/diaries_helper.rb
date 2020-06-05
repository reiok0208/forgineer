module DiariesHelper
  PER = 10
  def option(diaries)
    if params[:option] == "日記の新しい順"
      @diaries = diaries.order(id: "DESC").page(params[:page]).per(PER)
    elsif params[:option] == "日記の古い順"
      @diaries = diaries.order(id: "ASC").page(params[:page]).per(PER)
    elsif params[:option] == "日記の更新日順"
      @diaries = diaries.order(updated_at: "DESC").page(params[:page]).per(PER)
    elsif params[:option] == "お気に入りが多い順"
      @diaries = diaries.joins(:favorites).group(:diary_id).order(Arel.sql('count(diary_id) desc')).page(params[:page]).per(PER)
    elsif params[:option] == "コメントが多い順"
      @diaries = diaries.joins(:comments).group(:diary_id).order(Arel.sql('count(diary_id) desc')).page(params[:page]).per(PER)
    elsif params[:option] == "PVが多い順"
      @diaries = diaries.joins(:impressions).group(:impressionable_id).order(Arel.sql('count(impressionable_id) desc')).page(params[:page]).per(PER)
    else
      @diaries = diaries.order(id: "DESC").page(params[:page]).per(PER) #params[:option]が空の場合はelseを通る
    end
  end
end
