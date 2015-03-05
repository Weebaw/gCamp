def sign_in_user
  user = User.new(first_name: 'George', last_name: 'Clinton', email: 'parliament@mothershipconnection.com', password: 'bringthafunk', password_confirmation: 'bringthafunk')
  user.save!
  visit sign_in_path
  fill_in :email, with: 'parliament@mothershipconnection.com'
  fill_in :password, with: 'bringthafunk'
  click_button 'Sign in'
end
