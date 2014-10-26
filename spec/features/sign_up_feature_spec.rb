feature "Signing up" do

	scenario "User can sign up" do
		visit '/'
		click_link 'Sign Up'
		expect(current_path).to eq('/user/new_user')
	end

	scenario "Has to sign up for the first time visits the page" do
		
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content('Welcome galicians')
		expect(User.first.user_name).to eq('galicians')
	end

	scenario "After signs up is redirected to his profile page" do
		
		sign_up
		expect(current_path).to eq('/user/profile')
	end
end

feature "Errors during the sign up" do
	
	scenario "The email must be unique" do

		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		
		expect(page).to have_content("Email is already taken")
	end

	scenario "The email field can not be empty" do

		expect{ sign_up('','secret','secret','Pablo','galicians') }.to change(User, :count).by(0)
		expect(page).to have_content("The email field can not be empty")
	end

	scenario "The email must have an email format" do

		expect{ sign_up('galicians@gmail','secret','secret','Pablo','galicians') }.to change(User, :count).by(0)
		expect(page).to have_content("Bad email format")
	end

	scenario "The user name must be unique" do

		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		
		expect(page).to have_content("User name is already taken")
	end

	scenario "The user name field can not be empty" do

		expect{ sign_up('galicians@gmail.com', 'secret', 'secret', 'Pablo', '') }.to change(User, :count).by(0)
		expect(page).to have_content("The user name field can not be empty")
	end

	scenario "The name field can not be empty" do

		expect{ sign_up('galicians@gmail.com', 'secret', 'secret', '', 'galicians') }.to change(User, :count).by(0)
		expect(page).to have_content("The name field can not be empty")
	end


	
	scenario "The password and password confirmation must match" do 
		
		expect{ sign_up('galicians@gmail.com', 'secret', 's3cr3t0', 'Pablo', 'galicians') }.to change(User, :count).by(0)
		expect(page).to have_content("Password does not match the confirmation")
	end



end


def sign_up(email                 = 'galicians@gmail.com', 
	          password              = 'secret',
	          password_confirmation = 'secret',
	          name                  = 'Pablo',
	          user_name             = 'galicians')
	
	visit '/user/new_user'

	fill_in :email                 ,with: email
	fill_in :password              ,with: password
	fill_in :password_confirmation ,with: password_confirmation
  fill_in :name                  ,with: name
  fill_in :user_name             ,with: user_name

  click_button 'Save Chitter'
end

