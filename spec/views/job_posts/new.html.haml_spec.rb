require 'rails_helper'

RSpec.describe 'job_posts/new', type: :view do
  before(:each) do
    assign(:job_post, JobPost.new(
                        title: 'MyString',
                        identifier: 'MyString',
                        description: 'MyText',
                        raw_data: 'MyText',
                        budget: 1,
                        url: 'MyString'
    ))
  end

  it 'renders new job_post form' do
    render

    assert_select 'form[action=?][method=?]', job_posts_path, 'post' do

      assert_select 'input#job_post_title[name=?]', 'job_post[title]'

      assert_select 'input#job_post_identifier[name=?]', 'job_post[identifier]'

      assert_select 'textarea#job_post_description[name=?]', 'job_post[description]'

      assert_select 'textarea#job_post_raw_data[name=?]', 'job_post[raw_data]'

      assert_select 'input#job_post_budget[name=?]', 'job_post[budget]'

      assert_select 'input#job_post_url[name=?]', 'job_post[url]'
    end
  end
end
