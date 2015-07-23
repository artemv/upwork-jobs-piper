class CreateJobPosts < ActiveRecord::Migration

  def change
    create_table :job_posts do |t|
      t.string :title
      t.string :identifier, index: true
      t.text :description
      t.text :raw_data
      t.integer :budget, index: true
      t.datetime :post_date, index: true
      t.string :url
      t.string :status, null: false, index: true

      t.timestamps null: false
    end
  end

end
