require "rails_helper"

RSpec.describe JobPostsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/job_posts").to route_to("job_posts#index")
    end

    it "routes to #new" do
      expect(:get => "/job_posts/new").to route_to("job_posts#new")
    end

    it "routes to #show" do
      expect(:get => "/job_posts/1").to route_to("job_posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/job_posts/1/edit").to route_to("job_posts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/job_posts").to route_to("job_posts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/job_posts/1").to route_to("job_posts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/job_posts/1").to route_to("job_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/job_posts/1").to route_to("job_posts#destroy", :id => "1")
    end

  end
end
