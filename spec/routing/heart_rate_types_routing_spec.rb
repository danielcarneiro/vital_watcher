require "spec_helper"

describe HeartRateTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/heart_rate_types").should route_to("heart_rate_types#index")
    end

    it "routes to #new" do
      get("/heart_rate_types/new").should route_to("heart_rate_types#new")
    end

    it "routes to #show" do
      get("/heart_rate_types/1").should route_to("heart_rate_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/heart_rate_types/1/edit").should route_to("heart_rate_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/heart_rate_types").should route_to("heart_rate_types#create")
    end

    it "routes to #update" do
      put("/heart_rate_types/1").should route_to("heart_rate_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/heart_rate_types/1").should route_to("heart_rate_types#destroy", :id => "1")
    end

  end
end
