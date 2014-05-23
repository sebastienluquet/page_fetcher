require "spec_helper"

describe PagesController do
  describe "routing" do

    it "routes to #index" do
      get("/pages").should route_to("pages#index")
    end

    it "routes to #show" do
      get("/pages/1").should route_to("pages#show", :id => "1")
    end

    it "routes to #create" do
      post("/pages").should route_to("pages#create")
    end

  end
end
