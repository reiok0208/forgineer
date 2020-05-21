module DiariesHelper
  def tagcreate(name)
    @tags = params[:name].split(",")
      @tags.each do |tag|
        tag_downcase = tag.downcase
        tag_space_delete = tag_downcase.gsub(" ", "")
        Tag.create(name: tag_space_delete)
      end
  end
end
