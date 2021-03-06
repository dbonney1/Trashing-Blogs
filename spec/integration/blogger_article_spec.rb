require 'rails_helper.rb'

feature"Blogger article related tests" do
    def create_user(name, email)
        visit root_path
        expect(page).to have_content("Sign Up")
        click_link "Sign Up"
        expect(page).to have_content("New User")
        fill_in "Name", with: name
        fill_in "Email", with: email
        fill_in "Password", with: "test123"
        fill_in "Password confirmation", with: "test123"
        click_button "Create User"
        
        expect(page).to have_content("Let's set up your profile! Create my Profile!")
        click_link "Create my Profile!"
        expect(page).to have_content("New Profile")
        fill_in "Bio", with: "Reeee"
        fill_in "Description", with: "testing123123"
        click_button "Create Profile"
        expect(page).to have_content("User Profile")
        expect(page).to have_content("Reeee")
        expect(page).to have_content("testing123123")
        click_link "Back"
        expect(page).to have_content("Welcome to TrashingBlogs")
    end
    
    def sign_in(name, email)
        create_user(name, email)
        
        click_link "Log In"
        expect(page).to have_content("Login")
        fill_in "Email", with: email
        fill_in "Password", with: "test123"
        click_button "Login"
    end
    
    def create_article(title, text, tag)
        expect(page).to have_content("New Article")
        fill_in "Title", with: title
        fill_in "Text", with: text
        fill_in "Tags (seprated by commas)", with: tag
        click_button "Create Article"
        expect(page).to have_content(title)
        expect(page).to have_content(text)
    end
    
    scenario "Blogger successfully signs in and creates a new article" do
        sign_in("Anon123", "test@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
        create_article("New Capybara Article", "This is a new Capybara article", "testtag")
    end
    
    scenario "Blogger successfully signs in and creates a new article, edit it and delete it" do
        sign_in("Anon123", "test@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
        create_article("Tests", "Tests content", "testtag")
        
        click_link "Article List"
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests content")
        click_button "Show More"
        click_button "Edit"
        fill_in "Title", with: "Edited: Tests"
        fill_in "Text", with: "New Edit: Tests content"
        click_button "Update Article"
        expect(page).to have_content("Edited: Tests")
        expect(page).to have_content("New Edit: Tests content")
        click_link "Article List"
        expect(page).to have_content("Edited: Tests")
        expect(page).to have_content("New Edit: Tests ")
        click_button "Show More"
        click_button "Destroy"
        expect(page).to have_no_content("Edited: Tests")
        expect(page).to have_no_content("New Edit: Tests content")
    end
    
    scenario "Blogger successfully signs in and creates a new article and add a comment to it" do
        sign_in("Anon123", "test@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
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
        expect(page).to have_no_content("Create an Article")
    end
    
    scenario "Blogger add a report about an article and inspects it" do
        sign_in("Anon123", "test@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
        create_article("Tests", "Tests content", "testtag")
        
        click_link "Article List"
        click_button "Show More"
        click_button "Report Abuse"
        fill_in "Reason", with: "Abuse test"
        fill_in "Body", with: "test123123123"
        click_button "Save Abuse report"
        
        # click_link "Abuse Reports"
        # expect(page).to have_content("Abuse test")
        # expect(page).to have_content("test123123123")
        # click_link "Show"
        # expect(page).to have_content("Report Info:")
        # expect(page).to have_content("Abuse test")
        # expect(page).to have_content("test123123123")
        
        # click_link "Inspect Article"
        # expect(page).to have_content("Tests")
        # expect(page).to have_content("Tests content")
    end
    
    scenario "Blogger create articles, check out the tags for them and find similar articles" do
        sign_in("Anon123", "test@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
        create_article("Tests", "Test content", "testtag")
        click_link "Article List"
        click_button "Create an Article"
        create_article("Tests2", "Test content", "testtag, test2")
        click_link "Article List"
        click_button "Create an Article"
        create_article("Test3", "Test content", "testtag, test3")
        click_link "Article List"
        click_button "Create an Article"
        create_article("Test4", "Test content", "test3")
        click_link "Article List"
        
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests2")
        expect(page).to have_content("Test3")
        expect(page).to have_content("Test4")
        
        expect(page).to have_content("testtag")
        expect(page).to have_content("test2")
        expect(page).to have_content("test3")
        first(:link, "testtag").click
        
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests2")
        expect(page).to have_content("Test3")
        expect(page).to have_no_content("Test4")
        click_link "Article List"
        
        first(:link, "test3").click
        expect(page).to have_content("Test3")
        expect(page).to have_content("Test4")
        expect(page).to have_no_content("Tests")
        expect(page).to have_no_content("Tests2")
    end
    
    scenario "Blogger sign in and wants to edit profile" do
        visit root_path
        expect(page).to have_no_content("Profile")
        sign_in("Anon123", "test@gmail.com")
        expect(page).to have_content("Profile")
        click_link "Profile"
        click_link "Edit my User Info"
        fill_in "Name", with: "test"
        fill_in "Password", with: "test123"
        fill_in "Password confirmation", with: "test123"
        click_button "Update User"
        expect(page).to have_content("Name: test")
        
        click_link "Edit my Profile Info"
        fill_in "Bio", with: "something"
        click_button "Update Profile"
        expect(page).to have_content("User Profile")
        expect(page).to have_content("something")
    end
    
    scenario "Blogger sees another blogger, subscribe and give a like" do
        sign_in("Test1", "test2@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
        create_article("New Capybara Article", "This is a new Capybara article", "testtag")
        
        click_link "Log Out"
        
        sign_in("Test2", "test3@gmail.com")
        
        click_link "Article List"
        click_button "Create an Article"
        
        create_article("Tests", "Some contet", "test")
        
        click_link "Log Out"
        sign_in("Test", "test@gmail.com")
        click_link "Article List"
        first(:button, "Show More").click
        click_button "Like!"
        expect(page).to have_content("1 like")
        click_button "Subscribe"
        click_link "Feed"
        expect(page).to have_content("Test2")
        expect(page).to have_content("Tests")
        expect(page).to have_no_content("Test1")
    end
end