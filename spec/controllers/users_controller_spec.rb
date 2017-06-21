require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #TODO Finish this
  describe '#destroy' do
    context 'when resource is found' do
      it 'responds with 200'
      it 'shows the resource'
    end

    context 'when resource is not found' do
      it 'responds with 404'
    end
  end

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'loads all of the users into @users' do
      user1, user2 = User.create!, User.create!
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end
end
