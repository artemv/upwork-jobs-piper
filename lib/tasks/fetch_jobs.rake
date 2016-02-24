namespace :upwork_jobs do

  task fetch_jobs: :environment do
    begin
      JobPost.import_from_upwork
    rescue => e
      NewRelic::Agent.notice_error(e)
    end
  end

end
