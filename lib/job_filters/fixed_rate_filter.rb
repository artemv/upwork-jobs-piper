module JobFilters
  class FixedRateFilter
    def self.good_job?(job)
      return false if job['budget'].to_i > 1000
      return false if job['budget'].to_i < 50

      title_downcased = job['title'].downcase
      return false if %w(psd php odoo yii mql4 seo java wcf asp).any? { |bad_word| title_downcased =~ /\b#{bad_word}\b/ }
      bad_substrings = %w(moodle woocommerce magento phpbb wordpress laravel joomla python duplicate prestashop drupal) +
          %w(salesforce sakai asp.net opencart verilog codeigniter cakephp oscommerce mediawiki smarty whmcs) +
          %w(telerik)
      %w(bigcommerce) + # until at least I learn them
          ['business catalyst', 'mql 4', 'zen cart', 'word press', 'gravity forms']
      return false if bad_substrings.any? { |bad_susbstr| title_downcased[bad_susbstr] }
      return false if job['skills'].size == 1 && job['skills'][0] == 'php'

      true
    end
  end
end