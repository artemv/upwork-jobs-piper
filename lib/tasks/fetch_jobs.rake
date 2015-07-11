namespace :upwork_jobs do

  task fetch_jobs: :environment  do
    JobPost.import_from_upwork
  end

end
