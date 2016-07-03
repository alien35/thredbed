require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  describe "GET #follow_user" do
    it "returns http success" do
      get :follow_user
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unfollow_user" do
    it "returns http success" do
      get :unfollow_user
      expect(response).to have_http_status(:success)
    end
  end

end
