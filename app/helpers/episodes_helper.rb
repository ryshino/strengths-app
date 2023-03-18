module EpisodesHelper
  # 改行を反映させるためメソッド
  # http://taustation.com/rails-reflecting-newline-code/
  def html_safe_newline(str)
    h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
  end

  def episode_tags_info(episode)
    # エピソードに紐づくタグ名と選択された数を取得
    tag_counts = episode.tags.group(:name).count
    # ハッシュ形式で返している
    {
      tag_name: tag_counts.keys.first,
      tag_count: tag_counts.values.first,
      other_tag_count: tag_counts.size - 1
    }
  end
end
