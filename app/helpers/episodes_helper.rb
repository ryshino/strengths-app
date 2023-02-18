module EpisodesHelper
  # 改行を反映させるためメソッド
  # http://taustation.com/rails-reflecting-newline-code/
  def html_safe_newline(str)
    h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
  end

  def episode_tag_name(episode)
    episode.tags.group(:name).count.first.first
  end

  def episode_tag_count(episode)
    episode.tags.group(:name).count.first.second
  end

  def other_episode_tas_count(episode)
    episode_tags = episode.tags.group(:name).drop(1)
    episode_tags.count
  end
end
