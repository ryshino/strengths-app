class TagRelationsController < ApplicationController

  def create
    @episode = Episode.find(params[:tag_relation][:episode_id])
    @tag_ids = params[:tag_relation][:tag_id]
    current_user.tag_relations.where("episode_id LIKE ?", @episode.id).delete_all
    # 空文字を除いてeach文を回している
    unless @tag_ids.nil?
      @tag_ids.each do |tag_id|
        tag_relation = TagRelation.new(tag_id: tag_id, episode_id: @episode.id, user_id: current_user.id)
        tag_relation.save
      end
    end
    redirect_to episode_path(@episode)
  end

  private
    
    def tag_params
      params.require(:tag_relation).permit(:episode_id, tag_id: [])
    end
end
