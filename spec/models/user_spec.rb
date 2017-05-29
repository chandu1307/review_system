require 'rails_helper'

RSpec.describe User, type: :model do


 describe 'validations' do
  it "is valid with valid attributes" do
    expect(User.new(name: 'Anything', email: "anyemail@gmail.com")).to be_valid
   end

   it "is not valid without a name" do
     expect(User.new(name: '', email: "anyemail@gmail.com")).to be_valid
    end

    it "is not valid without a email" do
      expect(User.new(name: 'Anything', email: "")).to be_valid
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
     expect(user.name).to eq('first')
     expect(user.email).to eq('test@test.com')
   end
 end

end
