# frozen_string_literal: true
class JobPostsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_job_post, only: [:hide]
  after_action :cors_set_access_control_headers
  skip_before_action :verify_authenticity_token, only: [:hide]

  # GET /job_posts
  # GET /job_posts.json
  def index
    jobs = basic_jobs_set
    jobs = jobs.best_priced if params[:best_prices]
    jobs = jobs.hourly if params[:hourly]
    init_index_vars(jobs)
  end

  def hourly
    init_index_vars(basic_jobs_set.hourly)
  end

  def hide
    @job_post.update(status: 'not_interested')
    render nothing: true, content_type: 'text/plain'
  end

  private

  def basic_jobs_set
    JobPost.active.ordered
  end

  # Use callbacks to share common setup or constraints between actions.
  def load_job_post
    @job_post = JobPost.find(params[:id])
  end

  def init_index_vars(jobs)
    @list_stats = {
      from: (jobs.first.post_date if jobs.first),
      to: (jobs.last.post_date if jobs.last),
      count: jobs.count
    }
    @job_posts = jobs.page(params[:page]).per(params[:limit] || 25)
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

end
