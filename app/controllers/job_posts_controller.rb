class JobPostsController < ApplicationController

  before_action :load_job_post, only: [:hide]

  # GET /job_posts
  # GET /job_posts.json
  def index
    x = JobPost.active
    x = x.best_priced if params[:best_prices]
    x = x.ordered
    init_index_vars(x)
    @list_stats = { from: (x.first.post_date.to_s(:long) if x.first), to: (x.last.post_date.to_s(:long) if x.last), count: x.count }
    @job_posts = x.page params[:page]
  end

  def hourly
    x = JobPost.active
    x = x.hourly
    x = x.ordered
    init_index_vars(x)
  end

  def hide
    @job_post.update(status: 'not_interested')
    render nothing: true, content_type: 'text/plain'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def load_job_post
    @job_post = JobPost.find(params[:id])
  end

  def init_index_vars(x)
    @list_stats = { from: (x.first.post_date.to_s(:long) if x.first), to: (x.last.post_date.to_s(:long) if x.last), count: x.count }
    @job_posts = x.page params[:page]
  end

end
