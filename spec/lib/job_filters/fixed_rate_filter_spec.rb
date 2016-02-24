RSpec.describe JobFilters::FixedRateFilter do
  let(:valid_job_data) { {'title' => 'lala', 'skills' => [], 'budget' => '150'} }

  let(:job_data) { valid_job_data.merge(spec_job_data) }

  describe 'budget' do
    describe "should not pass when it's too small" do
      let(:spec_job_data) { {'budget' => '10'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be false }
    end

    describe "should pass when it's fine" do
      let(:spec_job_data) { {'budget' => '200'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be true }
    end

    describe "should not pass when it's too big" do
      let(:spec_job_data) { {'budget' => '2000'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be false }
    end
  end

  describe 'bad words' do
    describe "should pass when it's fine" do
      let(:spec_job_data) { {'title' => 'no matter'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be true }
    end

    describe "should not pass when it has bad substring" do
      let(:spec_job_data) { {'title' => 'opencarts'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be false }
    end

    describe "should not pass when it has bad word" do
      let(:spec_job_data) { {'title' => 'great java project'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be false }
    end

    describe "should pass when it has bad word allowed as substring" do
      let(:spec_job_data) { {'title' => 'great javascript project'} }
      subject { JobFilters::FixedRateFilter.good_job?(job_data) }
      it { is_expected.to be true }
    end

  end

end
