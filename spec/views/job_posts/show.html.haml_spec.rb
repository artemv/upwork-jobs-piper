require 'rails_helper'

RSpec.describe "job_posts/show", type: :view do
  before(:each) do
    @job_post = assign(:job_post, JobPost.create!(
      :title => "Title",
      :identifier => "Identifier",
      :description => "MyText",
      :raw_data => "MyText",
      :budget => 1,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Url/)
  end
end
