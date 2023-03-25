module EpisodesHelper
  # 改行を反映させるためメソッド
  # http://taustation.com/rails-reflecting-newline-code/
  def html_safe_newline(str)
    safe_join(str.split(/\n|\r|\r\n/), tag.br).html_safe
  end

  def episode_tags_info(episode)
    # 選択されたタグの多い順、同数の場合はタグ名で昇順にしている
    tag_counts = episode.tags.group(:name).count.sort_by { |name, count| [-count, name] }
    tag_name, tag_count = tag_counts.first
    {
      tag_name: tag_name,
      tag_count: tag_count,
      other_tag_count: tag_counts.size - 1
    }
  end
    
end
