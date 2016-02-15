require 'rails_helper'

RSpec.describe 'JobPosts', type: :request do
  describe 'GET /job_posts' do
    context 'with empty data' do
      context 'data' do
        subject { JobPost.first }
        it { is_expected.to be_nil }
      end

      it 'works' do
        get job_posts_path
        expect(response).to have_http_status(200)
      end
    end

    context 'with non-empty data' do
      let(:jobs_data) do
        JSON.parse(File.open(Rails.root.join('spec', 'support', 'fixtures', 'jobs_search', 'list.json')).read)
      end

      before(:example) do
        JobPost.import_upwork_jobs(jobs_data)
      end

      context 'data' do
        subject { JobPost.first }
        it { is_expected.not_to be_nil }
      end

      it 'works' do
        get job_posts_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
