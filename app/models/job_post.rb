class JobPost < ActiveRecord::Base
  FETCH_GAP = 2.hours

  serialize :raw_data

  scope :active, -> { where(status: "active") }
  scope :best_priced, -> { where(["budget < 1000 AND budget > 190"]) }

  def self.import_from_upwork
    last_post = JobPost.order(:post_date).last
    until_date = if last_post
                  last_post.post_date - FETCH_GAP
                 else
                   Time.now - 7.days
                 end
    JobsFinder.new(until_date).find.each do |job_data|
      identifier = job_data["id"]
      next if JobPost.find_by_identifier(identifier)
      JobPost.create!({
                          raw_data: job_data,
                          identifier: identifier,
                          title: job_data["title"],
                          description: job_data["snippet"],
                          budget: job_data["budget"],
                          post_date: job_data[JobsFinder::CREATED_DATE_FIELD],
                          url: job_data["url"],
                          status: "active"
                      })
    end
  end

  def skills
    raw_data["skills"]
  end
end
