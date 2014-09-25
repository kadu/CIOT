require "rails_helper"

RSpec.describe TriggersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/triggers").to route_to("triggers#index")
    end

    it "routes to #new" do
      expect(:get => "/triggers/new").to route_to("triggers#new")
    end

    it "routes to #show" do
      expect(:get => "/triggers/1").to route_to("triggers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/triggers/1/edit").to route_to("triggers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/triggers").to route_to("triggers#create")
    end

    it "routes to #update" do
      expect(:put => "/triggers/1").to route_to("triggers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/triggers/1").to route_to("triggers#destroy", :id => "1")
    end

  end
end
