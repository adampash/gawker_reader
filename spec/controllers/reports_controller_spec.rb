require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #politburo" do
    it "returns http success" do
      get :politburo
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
