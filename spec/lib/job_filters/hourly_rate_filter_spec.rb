# frozen_string_literal: true
RSpec.describe JobFilters::HourlyRateFilter do
  let(:valid_job_data) { { 'title' => 'ruby' } }

  let(:job_data) { valid_job_data.merge(spec_job_data) }

  describe "should pass when it's fine" do
    let(:spec_job_data) { { 'title' => 'great rails project' } }
    subject { JobFilters::HourlyRateFilter.good_job?(job_data) }
    it { is_expected.to be true }
  end

  describe 'should not pass when it has no whitelisted substring' do
    let(:spec_job_data) { { 'title' => 'great project' } }
    subject { JobFilters::HourlyRateFilter.good_job?(job_data) }
    it { is_expected.to be false }
  end

end
