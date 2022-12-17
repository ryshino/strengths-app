module EpisodesHelper
  # 改行を反映させるためメソッド
  # http://taustation.com/rails-reflecting-newline-code/
  def html_safe_newline(str)
    h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
  end
end
