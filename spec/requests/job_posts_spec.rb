require 'rails_helper'

RSpec.describe 'JobPosts', type: :request do
  describe 'GET /job_posts' do
    it 'works with empty data' do
      get job_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
