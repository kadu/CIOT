require 'rails_helper'

RSpec.describe "Triggers", :type => :request do
  describe "GET /triggers" do
    it "works! (now write some real specs)" do
      get triggers_path
      expect(response.status).to be(200)
    end
  end
end
