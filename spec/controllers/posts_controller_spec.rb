require_relative '../spec_helper'
require_relative '../rails_helper'

describe PostsController do
  describe "POST create" do
    render_views
    it "gets stuff from an api" do
      params = {url: "http://gawker.com/heres-how-much-medical-procedures-cost-in-different-cit-1691661767"}
      post :create, params.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', url: "http://gawker.com/heres-how-much-medical-procedures-cost-in-different-cit-1691661767" }
      expect(response.body).to match "Medical Procedures"
    end
  end
end
