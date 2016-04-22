require 'rails_helper'

feature 'Manage todos on the list', :js => true do
  scenario 'We can create new tasks' do
    title = 'Task to do'
    visit root_path
    fill_in 'todo_title', with: title
    page.execute_script("$('form').submit()")
    expect(page).to have_content(title)
  end

  scenario "Change the counter of tasks", :js => true do
    title = 'Task to do'
    visit root_path
    fill_in 'todo_title', with: title
    page.execute_script("$('form').submit()")
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
    check('todo-1')
    sleep 1
    
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
  end
end
