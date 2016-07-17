class AddCachedVotesToResponses < ActiveRecord::Migration
  def self.up
    add_column :responses, :cached_votes_score, :integer, :default => 0
    add_column :responses, :cached_votes_up, :integer, :default => 0
    add_index  :responses, :cached_votes_score
    add_index  :responses, :cached_votes_up

    # Uncomment this line to force caching of existing votes
    # Post.find_each(&:update_cached_votes)
  end

  def self.down
    remove_column :responses, :cached_votes_total
    remove_column :responses, :cached_votes_score
    remove_column :responses, :cached_votes_up
    remove_column :responses, :cached_votes_down
    remove_column :responses, :cached_weighted_score
    remove_column :responses, :cached_weighted_total
    remove_column :responses, :cached_weighted_average
  end
end
