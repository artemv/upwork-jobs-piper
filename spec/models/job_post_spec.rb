describe 'JobPost' do
  describe 'import_upwork_job' do
    let(:jobs_data) do
      load_json_fixtures_map('jobs_search', 'list.json')
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
  end
end
