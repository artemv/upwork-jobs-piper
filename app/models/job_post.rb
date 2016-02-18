class JobPost < ActiveRecord::Base

  FETCH_GAP = 2.hours
  FIRST_FETCH_RANGE = 14.days

  serialize :raw_data

  scope :active, -> { where(status: 'active') }
  scope :best_priced, -> { where(['budget < 1000 AND budget > 190']) }
  scope :hourly, -> { where(['budget is null']) }
  scope :ordered, -> { order('post_date desc') }

  def self.import_from_upwork
    last_post = JobPost.order(:post_date).last
    until_date = if last_post
                   last_post.post_date - FETCH_GAP
                 else
                   Time.now - FIRST_FETCH_RANGE
                 end
    import_upwork_jobs(JobsFetcher.new(until_date).fetch)
  end

  def self.import_upwork_jobs(jobs_data)
    jobs_data.each { |job_data| import_upwork_job(job_data) }
  end

  def self.import_upwork_job(job_data)
    identifier = job_data['id']
    return if find_by_identifier(identifier)
    self.create!(raw_data: job_data,
                 identifier: identifier,
                 title: job_data['title'],
                 description: job_data['snippet'],
                 budget: (job_data['job_type'] == 'Hourly' ? nil : job_data['budget']),
                 money_level: job_data['op_contractor_tier'],
                 post_date: job_data[JobsFetcher::CREATED_DATE_FIELD],
                 url: job_data['url'],
                 status: 'active')
  end

  def skills
    raw_data['skills']
  end

  def great_word_job?(word)
    skills.any? { |skill| skill.include?(word) } || description.downcase.include?(word) || title.downcase.include?(word)
  end

  def great_job?
    return true if JobFilters::HourlyRateFilter::WHITELIST.any? { |word| self.great_word_job?(word) }
    return true if %w(node.js angular.js angular).any? { |word| self.great_word_job?(word) }
  end

  def country
    raw_data['client']['country']
  end

  def contractor_tier_key
    tier = money_level.to_i
    return :entry if tier == 1
    return :intermediate if tier == 2
    return :expert if tier == 3
  end
end
