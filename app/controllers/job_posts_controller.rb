class JobPostsController < ApplicationController

  before_action :set_job_post, only: [:hide]

  # GET /job_posts
  # GET /job_posts.json
  def index
    x = JobPost.active
    x = x.best_priced if params[:best_prices]
    x = x.hourly if params[:hourly]
    x = x.order('post_date desc')
    @list_stats = { from: x.first.post_date.to_s(:long), to: x.last.post_date.to_s(:long), count: x.count }
    @job_posts = x.page params[:page]
  end

  def hide
    @job_post.update(status: 'not_interested')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job_post
    @job_post = JobPost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_post_params
    params.require(:job_post).permit(:title, :identifier, :description, :raw_data, :budget, :post_date, :url)
  end

end
