require 'rails_helper'

RSpec.describe JobPostsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/job_posts').to route_to('job_posts#index')
    end

  end
end
