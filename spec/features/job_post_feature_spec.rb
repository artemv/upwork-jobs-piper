require 'pry' # To be able to jump into pry debugger via binding.pry.
# This can be useful for debugging when using Selenium driver - thus the browser doesn't get closed while debugging
# session is active.

describe 'Job post' do

  pathes = ['/', '/hourly']

  describe 'with data' do
    let(:path) { '/' }

    before :example do
      JobPost.import_upwork_jobs(load_json_fixture('jobs_search', 'list.json'))
      visit path
    end

    pathes.each do |p|
      describe "should show jobs at #{p} path" do
        let(:path) { p }

        subject { page }

        it { is_expected.to have_css('tr.job_post') }
      end
    end

    describe 'hiding a post', js: true do

      it 'should work' do
        first_post = JobPost.first
        job_row_selector = %Q{tr.job_post[data-id="#{first_post.id}"]}
        expect(page).to have_css(job_row_selector) # pre-requisite
        find(%Q{#{job_row_selector} button.close}).click
        expect(page).not_to have_css(job_row_selector)

        visit path # re-visit the page
        expect(page).not_to have_css(job_row_selector) # the hide persists
      end
    end
  end

  describe 'without data' do

    pathes.each do |path|
      describe "should not blow at #{path}" do
        before :example do
          visit path
        end

        subject { page }

        it { is_expected.to have_text('job posts') }
      end
    end

  end

end
