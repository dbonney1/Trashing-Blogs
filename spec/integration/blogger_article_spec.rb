require 'rails_helper.rb'

feature"Blogger article related tests" do
    scenario "Blogger successfully navigates to the new articles page from the listing articles page" do
        visit root_path
        click_link "Article List"
        expect(page).to have_content("Listing articles")
        click_link "New article"
        expect(page).to have_content("New Article")
        expect(page).to have_field("Title")
        expect(page).to have_field("Text")
    end
    
    scenario "Blogger successfully creates a new article" do
        visit new_article_path
        expect(page).to have_content("New Article")
        fill_in "Title", with: "New Capybara Article"
        fill_in "Text", with: "This is a new Capybara article"
        click_button "Create Article"
        expect(page).to have_content("New Capybara Article")
        expect(page).to have_content("This is a new Capybara article")
    end
    
    scenario "Blogger successfully creates a new article, edit it and delete it" do
        visit new_article_path
        expect(page).to have_content("New Article")
        fill_in "Title", with: "Tests"
        fill_in "Text", with: "Tests content"
        click_button "Create Article"
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests content")
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
    
    scenario "Blogger successfully creates a new article and add a comment to it" do
        visit new_article_path
        expect(page).to have_content("New Article")
        fill_in "Title", with: "Tests"
        fill_in "Text", with: "Tests content"
        click_button "Create Article"
        expect(page).to have_content("Tests")
        expect(page).to have_content("Tests content")
        fill_in "Commenter", with: "Anon123"
        fill_in "Body", with: "This is a comment"
        click_button "Create Comment"
        expect(page).to have_content("Commenter Anon123")
        expect(page).to have_content("Comment This is a comment")
    end
end