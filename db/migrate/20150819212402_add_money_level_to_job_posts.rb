# frozen_string_literal: true
class AddMoneyLevelToJobPosts < ActiveRecord::Migration
  def change
    add_column :job_posts, :money_level, :integer
    add_index :job_posts, :money_level
  end
end
