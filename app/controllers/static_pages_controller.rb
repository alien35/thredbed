class StaticPagesController < ApplicationController
  before_action :count_tags

  def learn
  end

  def count_tags
    @tag_counts = Post.tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
  end
end
