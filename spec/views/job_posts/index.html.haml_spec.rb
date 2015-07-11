require 'rails_helper'

RSpec.describe "job_posts/index", type: :view do
  before(:each) do
    assign(:job_posts, [
      JobPost.create!(
        :title => "Title",
        :identifier => "Identifier",
        :description => "MyText",
        :raw_data => "MyText",
        :budget => 1,
        :url => "Url"
      ),
      JobPost.create!(
        :title => "Title",
        :identifier => "Identifier",
        :description => "MyText",
        :raw_data => "MyText",
        :budget => 1,
        :url => "Url"
      )
    ])
  end

  it "renders a list of job_posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
