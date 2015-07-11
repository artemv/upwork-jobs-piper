class MyFixedRateJobsFilter

  attr_reader :jobs, :main_category

  def initialize(jobs, main_category)
    @jobs = jobs
    @main_category = main_category
  end

  def filter
    result = jobs.select do |job|
      good_job?(job)
    end
    log "#{result.size} jobs left by #{self.class.name}"
    result
  end

  def good_job?(job)
    return false unless ["Web Development", "Ecommerce Development", "Other - Software Development", "Scripts & Utilities",
     "QA & Testing"].push(main_category).include?(job["subcategory2"])

    unless job["title"]
      Rails.logger.error("job #{job.inspect} has no title, strange")
      return false
    end
    title_downcased = job["title"].downcase

    return false unless job["job_type"] == "Fixed"
    return false if job["budget"].to_i > 1000
    return false if job["budget"].to_i < 50
    return false if %w(psd php odoo yii mql4 seo java wcf).any? { |bad_word| title_downcased =~ /\b#{bad_word}\b/ }
    bad_substrings = %w(moodle woocommerce magento phpbb wordpress laravel joomla python duplicate prestashop drupal) +
        %w(salesforce sakai asp.net opencart verilog codeigniter cakephp oscommerce mediawiki smarty whmcs) +
        %w(bigcommerce) + # until at least I learn them
        ["business catalyst", "mql 4", "zen cart", "word press", "gravity forms"]
    return false if bad_substrings.any? { |bad_susbstr| title_downcased[bad_susbstr] }
    return false if job["skills"].size == 1 && job["skills"][0] == 'php'
    true
  end

end
