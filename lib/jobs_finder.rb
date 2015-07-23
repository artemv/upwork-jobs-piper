require "upwork/api"
require "upwork/api/routers/jobs/search"

class JobsFinder

  attr_accessor :client_config, :until_date

  PAGE_SIZE = 100
  DEV_CATEGORY = "Web, Mobile & Software Dev"
  CREATED_DATE_FIELD = "date_created"

  def initialize(until_date)
    @client_config = Upwork::Api::Config.new(Rails.application.secrets.upwork_api)
    @until_date = until_date
  end

  def find
    client = Upwork::Api::Client.new(client_config)
    search = Upwork::Api::Routers::Jobs::Search.new(client)
    category = DEV_CATEGORY
    page_idx = 1
    jobs = []
    last_post_date = nil
    while !last_post_date || last_post_date >= until_date
      last_page_job = process_page(page_idx, jobs, search, category)
      last_post_date = Time.parse(last_page_job[CREATED_DATE_FIELD]) if last_page_job
      log("last_post_date of page #{page_idx}: #{last_post_date}")
      break unless last_page_job
      page_idx += 1
    end
    jobs
  end

  def process_page(page_idx, jobs, search, category)
    page_jobs = Timed.run(lambda { |delta, result| "#{delta}s spent by Upwork API to find #{result.size} jobs on page #{page_idx}" }) do
      query = {"title" => "",
               "category2" => category,
               "sort" => "create_time desc",
               "paging" => "#{PAGE_SIZE*(page_idx - 1)};#{PAGE_SIZE}"
      }
      log("running Upwork query: #{query}")
      results = search.find(query)
      result = results["jobs"]
      unless result
        msg = "API returned no jobs for query #{query.inspect}: #{results.inspect}"
        Rails.logger.error(msg)
        raise msg unless results.inspect["Duplicate timestamp/nonce combination"]
      end
      result || []
    end
    last_page_job = page_jobs[-1]
    if last_page_job
      jobs.concat(MyFixedRateJobsFilter.new(page_jobs, category).filter)
    end
    return last_page_job
  end

end
