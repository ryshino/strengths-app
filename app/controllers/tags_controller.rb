class TagsController < ApplicationController
  def update
    @episode = Episode.find(params[:id])
    @tag_ids = params[:episode][:tag_ids]
    @episode.tag_relations.delete_all
    # 空文字を除いてeach文を回している
    @tag_ids.reject { |id| id.blank? }.each do |tag_id|
     @episode.tag_relations.build(tag_id: tag_id, user_id: current_user.id)
    end
    @episode.save
    redirect_to episode_path(@episode)
  end

  private
    
    def tag_params
      params.require(:episode).permit(tag_ids: [])
    end
end
