class StaticPagesController < ApplicationController
  before_action :count_tags

  def learn
  end

  def count_tags
      @tag_counts = Post.where("created_at > ?", Time.now - 5.days).tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
    end
end
