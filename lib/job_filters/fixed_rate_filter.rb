module JobFilters

  class FixedRateFilter

    BAD_WORDS = %w(psd php odoo yii mql4 seo java wcf asp).freeze
    BAD_SUBSTRINGS = %w(moodle woocommerce magento phpbb wordpress laravel joomla python duplicate prestashop drupal) +
                     %w(salesforce sakai asp.net opencart verilog codeigniter cakephp oscommerce mediawiki smarty whmcs) +
                     %w(telerik bigcommerce) +
                     ['business catalyst', 'mql 4', 'zen cart', 'word press', 'gravity forms']
    MAX_BUDGET = 1000
    MIN_BUDGET = 50

    def self.good_job?(job_data)
      return false if bad_budget?(job_data['budget'].to_i)

      title_downcased = job_data['title'].downcase
      return false if BAD_WORDS.any? { |bad_word| title_downcased =~ /\b#{bad_word}\b/ }
      return false if BAD_SUBSTRINGS.any? { |bad_susbstr| title_downcased[bad_susbstr] }
      return false if job_data['skills'].size == 1 && BAD_WORDS.include?(job_data['skills'][0])

      true
    end

    def self.bad_budget?(value)
      return true if value > MAX_BUDGET
      return true if value < MIN_BUDGET
    end

  end

end
