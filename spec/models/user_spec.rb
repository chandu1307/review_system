require 'rails_helper'

RSpec.describe User, type: :model do


 describe 'validations' do
  it "is valid with valid attributes" do
    expect(User.new(name: 'Anything', email: "anyemail@gmail.com")).to be_valid
   end

   it "is not valid without a name" do
     user = User.new(name: '', email: "test@gmail.com")
     expect(user).not_to be_valid
     expect(user.errors.messages.keys).to include("name")
    end

    it "is not valid without a email" do
      user = User.new(name: 'Anything', email: "")
      expect(user).not_to be_valid
      expect(user.errors.messages.keys).to include("email")
     end
   end

  describe :from_omniauth do
   it 'should get all the user details from omniauth for successful authentication' do
     OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
       provider: 'google_oauth2',
       info: {
         first_name: 'first',
         last_name: 'last',
         email: 'test@gmail.com'
       }
     })
     user = User.from_omniauth(OmniAuth.config.mock_auth[:google_oauth2])
     expect(user.name).to eq('first last')
     expect(user.email).to eq('test@gmail.com')
   end
 end

end
