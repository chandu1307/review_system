require 'rails_helper'

RSpec.describe User, type: :model do

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
