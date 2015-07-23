module JobPostsHelper

  def job_post_class(job_post)
    'highlight' if job_post.great_job?
  end

end
