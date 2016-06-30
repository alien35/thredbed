module PostsHelper

  def title_max_length(str)
    str.split("").length > 100 ?
    str.split("")[0...100].join("") + "..." : str
  end

  def caption_max_length(str)
    str.split("").length > 300 ?
    str.split("")[0...300].join("") + "..." : str
  end

end
