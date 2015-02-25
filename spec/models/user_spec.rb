require 'rails_helper'


  describe User do
    it "requires a first name" do
      User.create( first_name: "Ben", last_name: "Steinbook", email: "ben@ben.com" )
      expect(user).to be_valid
    end
  end
