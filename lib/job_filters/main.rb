module JobFilters

  DEV_CATEGORY = 'Web, Mobile & Software Dev'.freeze
  DEV_SUBCATEGORIES = ['Web Development', 'Ecommerce Development', 'Other - Software Development',
                       'Scripts & Utilities', 'QA & Testing'].freeze
  FIXED_JOB_TYPE = 'Fixed'.freeze

  # Job filters composer
  class Main

    attr_reader :jobs

    def initialize(jobs)
      @jobs = jobs
    end

    def filter
      result = jobs.select do |job|
        good_job?(job)
      end
      logger.debug("#{result.size} jobs left by #{self.class.name}")
      result
    end

    def good_job?(job)
      return false unless (DEV_SUBCATEGORIES + [DEV_CATEGORY]).include?(job['subcategory2'])

      unless job['title']
        logger.error("job #{job.inspect} has no title, strange")
        return false
      end

      if job['job_type'] == FIXED_JOB_TYPE
        return false unless FixedRateFilter.good_job?(job)
      else
        return false unless HourlyRateFilter.good_job?(job)
      end
      true
    end

  end

end
