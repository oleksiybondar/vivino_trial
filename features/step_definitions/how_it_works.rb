# do not defining steps definition module and not initializing as world since all the action are hidden in page objects

# defined without block, since nothing to do, application launches on Before Hook
Given('Launched Vivino application') {}

When('User click \'How it works\' button') do
  @page.how_it_works_btn.click
end

Then('Slide description is {string}') do |expected_message|
  @page.how_it_works_slide.wait
  expect(@page.how_it_works_slide.description.text).to eq(expected_message)
end

When ('User click \'next\' button') do
  @page.how_it_works_slide.next_btn.click
end

And('Account creation buttons shown') do
  @page.continue_with_email.present!
  @page.continue_with_facebook.present!
  @page.continue_with_google.present!
end

When('User click \'Try us out\'') do
  @page = @page.try_out_application
end

Then('User see a {string} message') do |message|
  # this one is time consuming so page may loads for a quite long time
  @page.user_name.wait(30)
  expect(@page.user_name.text).to eq(message)
end

When('User navigates to a wine search') do
  @page = @page.nav_bar.navigate_to(:search)
end

Then('Search query is shown') do
  @page.search_btn.wait
  @page.search_btn.present!
end

When('User enters a {string}') do |keyword|
  @page.serch_wine keyword
end

Then('Search results are shown') do
  @page.wait_for_results
end

And('All results contains given {string}') do |keyword|
  @page.search_results_has_keyword(keyword)
end
