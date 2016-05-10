# frozen_string_literal: true
describe 'JobPost' do
  describe 'import_upwork_job' do
    let(:fixtures_dir) { 'jobs_search' }
    let(:fixtures_file) { 'list.json' }

    let(:jobs_data) do
      load_json_fixtures_map(fixtures_dir, fixtures_file)
    end

    describe 'hourly job with 0 budget' do
      let(:job_data) do
        jobs_data['~01df1e5ed63d0d8f37']
      end

      before(:example) do
        JobPost.import_upwork_job(job_data)
      end

      it 'should become an item of .hourly scope' do
        expect(job_data['budget']).to eq(0) # pre-requisite
        hourly = JobPost.hourly
        expect(hourly.count).to eq(1)
        expect(hourly.to_a[0].identifier).to eq(job_data['id'])
      end

    end

    describe 'import' do
      def jobs_endpoint(from, to)
        'https://www.upwork.com/api/profiles/v2/search/jobs.json?' \
          "category2=Web,%20Mobile%20%26%20Software%20Dev&paging=#{from}%3B#{to}&sort=create_time%20desc&title="
      end

      it 'should work' do
        stub_request(:get, jobs_endpoint(0, 100)).
          to_return(status: 200, body: { jobs: load_json_fixture(fixtures_dir, fixtures_file) }.to_json)

        stub_request(:get, jobs_endpoint(100, 100)).
          to_return(status: 200, body: { jobs: [] }.to_json)

        expect(JobPost.count).to eq(0)
        JobPost.import_from_upwork
        expect(JobPost.count).not_to eq(0)
      end
    end

  end
end
