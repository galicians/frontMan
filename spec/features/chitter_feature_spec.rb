require 'timecop'
require "./app/models/user"

feature "Home page" do

	time = Time.local(2014,10,24,12,0)

	Timecop.freeze(time)

	before(:each) do 


		Chitter.create(content: 'chitter marketplace', at_time: time)
	end

	scenario "The user visits the page for first time" do
		visit '/'

		expect(page).to have_content('Chitter')
		expect(page).to have_link( 'Sign Up' )
		expect(page).to have_link( 'Sign In' )
		expect(page).to have_content('chitter marketplace')
		expect(page).to have_content(time.strftime("%d/%b/%Y at %H:%M"))
	end
end

feature "Posting a chit" do
	time = Time.local(2014,10,24,12,0)

	Timecop.freeze(time)

	before(:each) do 
    user = User.create(email: "galicians@gmail.com", password: 'secret',password_confirmation: "secret",
		            name: "Pablo",  user_name: "galicians")

    sign_in('galicians','secret')

		Chitter.create(content: 'chitter marketplace', at_time: time, 
			            name: user.name, user_name: user.user_name)
	end

	scenario "The user must be log in" do

		fill_in 'content', with: 'testing'

		click_button 'Post a chit'

		expect(page).to have_content('chitter marketplace')
		expect(page).to have_content(time.strftime("%d/%b/%Y at %H:%M"))
		expect(page).to have_content('Pablo')
		expect(page).to have_content('galicians')
		expect(current_path).to eq('/user/profile')
	end
end
























