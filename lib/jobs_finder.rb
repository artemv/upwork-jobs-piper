require 'upwork/api'
require 'upwork/api/routers/jobs/search'
require 'job_filters/main'

class JobsFinder

  attr_accessor :client_config, :until_date

  PAGE_SIZE = 100
  CREATED_DATE_FIELD = 'date_created'

  def initialize(until_date)
    @client_config = Upwork::Api::Config.new(Rails.application.secrets.upwork_api)
    @until_date = until_date
  end

  def find
    client = Upwork::Api::Client.new(client_config)
    search = Upwork::Api::Routers::Jobs::Search.new(client)
    page_idx = 1
    jobs = []
    last_post_date = nil
    while !last_post_date || last_post_date >= until_date
      last_page_job = process_page(page_idx, jobs, search)
      last_post_date = Time.parse(last_page_job[CREATED_DATE_FIELD]) if last_page_job
      log("last_post_date of page #{page_idx}: #{last_post_date}")
      break unless last_page_job
      page_idx += 1
    end
    jobs
  end

  def process_page(page_idx, jobs, search)
    page_jobs = Timed.run(->(delta, result) { "#{delta}s spent by Upwork API to find #{result.size} jobs on page #{page_idx}" }) do
      query = { 'title' => '',
                'category2' => JobFilters::DEV_CATEGORY,
                'sort' => 'create_time desc',
                'paging' => "#{PAGE_SIZE * (page_idx - 1)};#{PAGE_SIZE}"
      }
      log("running Upwork query: #{query}")
      results = search.find(query)
      result = results['jobs']
      unless result
        msg = "API returned no jobs for query #{query.inspect}: #{results.inspect}"
        Rails.logger.error(msg)
        fail msg unless results.inspect['Duplicate timestamp/nonce combination']
      end
      result || []
    end
    last_page_job = page_jobs[-1]
    jobs.concat(JobFilters::Main.new(page_jobs).filter) if last_page_job
    last_page_job
  end

end
