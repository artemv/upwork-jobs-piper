# frozen_string_literal: true
module JobFilters

  # Implements hourly rate jobs filtering
  class HourlyRateFilter

    WHITELIST = %w(ruby rails es6 ecmascript6 es2015 ecmascript2015) + ['ecmascript 6', 'ecmascript 2015']

    def self.good_job?(job)
      return false if job['op_contractor_tier'].to_i == 1 # skip entry level for hourly jobs
      title_downcased = job['title'].downcase
      return true if WHITELIST.any? { |good_susbstr| title_downcased[good_susbstr] }
      false
    end

  end

end
