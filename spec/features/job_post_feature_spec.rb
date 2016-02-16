require 'pry' # To be able to jump into pry debugger via binding.pry.
# This can be useful for debugging when using Selenium driver - thus the browser doesn't get closed while debugging
# session is active.

describe 'Job post' do

  pathes = ['/', '/hourly']

  describe 'with data' do

    pathes.each do |path|
      describe path do
        before :example do
          JobPost.import_upwork_jobs(load_json_fixture('jobs_search', 'list.json'))
          visit path
        end

        subject { page }

        it { is_expected.to have_css('tr.job_post') }
      end
    end

  end

  describe 'without data' do

    pathes.each do |path|
      describe path do
        before :example do
          visit path
        end

        subject { page }

        it { is_expected.to have_text('job posts') }
      end
    end

  end

end
