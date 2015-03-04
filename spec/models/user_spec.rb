require 'rails_helper'


  describe User do
    it "requires a first name" do
      user = User.new
      expect(user).not_to be_valid
      user.update( first_name: "Ben", last_name: "Steinbook", email: "ben@ben.com", password: 'ben', password_confirmation: 'ben')
      expect(user).to be_valid
    end
  end
