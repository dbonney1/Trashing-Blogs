Given("I am on the home page") do
  visit root_path
end

When("I click on the {string} link") do |string|
  click_link string
end

Then("I should be on the {string} page") do |string|
  expect(page).to have_content(string)
end

Then("I should see the {string} field") do |string|
  expect(page).to have_field(string)
end

Given("I am on the New Article page") do
  visit new_article_path
end

When("I write in the {string} field with {string}") do |string, string2|
  fill_in string, :with => string2
end

When("I click on the {string} button") do |string|
  click_on string
end

Then("I should not find the {string} article") do |string|
  expect(page).to have_no_content(string)
end