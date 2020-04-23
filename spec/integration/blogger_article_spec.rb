require 'rails_helper.rb'

feature"Blogger article related tests" do
    def sign_in
        visit root_path
        expect(page).to have_content("Sign Up")
        click_link "Sign Up"
        expect(page).to have_content("New User")
        fill_in "Name", with: "Anon123"
        fill_in "Email", with: "test@gmail.com"
        fill_in "Password", with: "test123"
        fill_in "Password confirmation", with: "test123"
        click_button "Create User"
        
        expect(page).to have_content("User was successfully created.")
        expect(page).to have_content("Let's set up your profile! Create my Profile!")
        expect(page).to have_content("New Profile")
        fill_in "Bio", with: "Reeee"
        fill_in "Description", with: "testing123123"
        fill_in "Imageurl", with: "https://i.imgur.com/bhC7g1p.jpg"
        expect(page).to have_content("User Profile")
        expect(page).to have_content("User Bio reeee")
        expect(page).to have_content("User Description: testing123123")
        # expect(page).to have_content("Name: Anon123")
        # expect(page).to have_content("Email: test@gmail.com")
        # click_link "Back"
        # click_link "Back"
        
        # click_link "Log In"
        # expect(page).to have_content("Login")
        # fill_in "Email", with: "test@gmail.com"
        # fill_in "Password", with: "test123"
        # click_button "Login"
        # expect(page).to have_content("logged in as Anon123")
    end
    
    def create_article(title, text, tag)
        expect(page).to have_content("New Article")
        fill_in "Title", with: title
        fill_in "Text", with: text
        click_button "Create Article"
        expect(page).to have_content(title)
        expect(page).to have_content(text)
    end
    
    scenario "Blogger successfully navigates to the new articles page from the listing articles page" do
        visit root_path
        click_link "Article List"
        expect(page).to have_content("Listing articles")
        click_link "New article"
        expect(page).to have_content("New Article")
        expect(page).to have_field("Title")
        expect(page).to have_field("Text")
    end
    
    scenario "Blogger successfully signs in and creates a new article" do
        sign_in
        
        click_link "Article List"
        click_link "New article"
        
        create_article("New Capybara Article", "This is a new Capybara article", "testtag")
    end
    
    scenario "Blogger successfully signs in and creates a new article, edit it and delete it" do
        sign_in
        
        click_link "Article List"
        click_link "New article"
        
        create_article("Tests", "Tests content", "testtag")
        
        click_link "Article List"
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests content")
        click_link "Edit"
        fill_in "Title", with: "Edited: Tests"
        fill_in "Text", with: "New Edit: Tests content"
        click_button "Update Article"
        expect(page).to have_content("Edited: Tests")
        expect(page).to have_content("New Edit: Tests content")
        click_link "Article List"
        expect(page).to have_content("Edited: Tests")
        expect(page).to have_content("New Edit: Tests content")
        click_link "Destroy"
        expect(page).to have_no_content("Edited: Tests")
        expect(page).to have_no_content("New Edit: Tests content")
    end
    
    scenario "Blogger successfully signs in and creates a new article and add a comment to it" do
        sign_in
        
        click_link "Article List"
        click_link "New article"
        
        create_article("Tests", "Tests content", "testtag")
        
        fill_in "Commenter", with: "Anon123"
        fill_in "Body", with: "This is a comment"
        click_button "Create Comment"
        expect(page).to have_content("Commenter: Anon123")
        expect(page).to have_content("Comment: This is a comment")
    end
    
    scenario "Blogger cannot create new article when not signed in" do
        visit root_path
        click_link "Article List"
        click_link "New article"
        create_article("Tests", "Tests content", "testtag")
        expect(page).to have_content("User must exist")
    end
    
    scenario "Blogger add a report about an article and inspects it" do
        sign_in
        
        click_link "Article List"
        click_link "New article"
        
        create_article("Tests", "Tests content", "testtag")
        
        click_link "Report this Article"
        expect(page).to have_content("New Report")
        fill_in "Reason", with: "Abuse test"
        fill_in "Body", with: "test123123123"
        click_button "Save Abuse report"
        
        click_link "Abuse Reports"
        expect(page).to have_content("Abuse test")
        expect(page).to have_content("test123123123")
        click_link "Show"
        expect(page).to have_content("Report Info:")
        expect(page).to have_content("Abuse test")
        expect(page).to have_content("test123123123")
        
        click_link "Inspect Article"
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests content")
        
    end
    
end