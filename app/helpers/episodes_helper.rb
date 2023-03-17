module EpisodesHelper
  # 改行を反映させるためメソッド
  # http://taustation.com/rails-reflecting-newline-code/
  def html_safe_newline(str)
    h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
  end

  def episode_tags_info(episode)
    tags = episode.tags.group(:name).count.to_a
    {
      tag_name: tags.first[0],
      tag_count: tags.first[1],
      other_tag_count: tags.drop(1).count
    }
  end
end
