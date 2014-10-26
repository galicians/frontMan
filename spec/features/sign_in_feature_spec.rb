feature "Signing In" do

	scenario "A user can sign in" do
		
		visit '/'
		click_link 'Sign In'
    
    expect(current_path).to eq('/session/new_session')
	end

	scenario "After signing in with the correct credentials is redirect to his profile page" do

		User.create(email: "galicians@gmail.com", password: 'secret',password_confirmation: "secret",
	 	            name: "Pablo",  user_name: "galicians")

		sign_in('galicians','secret')

		expect(page).to have_content('Welcome galicians')
		expect(current_path).to eq('/user/profile')
	end

	scenario "Trying to sign in with a wrong user_name" do

		sign_in('Pabs','secret')
		expect(page).not_to have_content('Welcome Pablo')
		expect(page).to     have_content('There is a problem with your email or password')
	end

	scenario "Trying to sign in with a wrong password" do

		sign_in('galicians','secreto')
		expect(page).not_to have_content('Welcome Pablo')
		expect(page).to     have_content('There is a problem with your email or password')
	end

end

feature "Signing Out" do

	before(:each) do

		User.create(email: "galicians@gmail.com", password: 'secret',password_confirmation: "secret",
		            name: "Pablo",  user_name: "galicians")
	end

	scenario "the user can sign out" do

		sign_in('galicians','secret')
    click_button 'Sign Out'
		
		expect(current_path).to eq('/')
	end

	scenario "The user is redirect to his profile page if he doesn't log out" do
		
		sign_in('galicians','secret')

		visit '/'

		expect(current_path).to eq('/user/profile')
	end


end


def sign_in(user_name, password  )

	visit '/session/new_session'

	fill_in :user_name,             with: user_name
	fill_in :password,              with: password

	click_button 'Welcome'
end

