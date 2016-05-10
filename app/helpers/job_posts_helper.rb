# frozen_string_literal: true
module JobPostsHelper

  def job_post_class(job_post)
    'highlight' if !@hourly_only_mode && job_post.great_job?
  end

  def money_level(job_post)
    return '$$' if job_post.contractor_tier_key == :intermediate
    return '$$$' if job_post.contractor_tier_key == :expert
  end

end
