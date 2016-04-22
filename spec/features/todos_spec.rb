require 'rails_helper'

def create_todo(title)
  visit root_path
  fill_in 'todo_title', with: title
  page.execute_script("$('form').submit()")
end

feature 'Manage todos on the list', :js => true do
  scenario 'We can create new tasks' do
    title = 'Task to do'
    create_todo(title)
    expect(page).to have_content(title)
  end

  scenario "Change the counter of tasks", :js => true do
    title = 'Task to do'
    create_todo(title)

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
    check('todo-1')
    sleep 1

    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
  end

  scenario "Change the counter of tasks, check them and re-count", :js => true do
    title = 'Task to do'
    create_todo(title)
    title = 'Task to do2'
    create_todo(title)
    title = 'Task to do3'
    create_todo(title)

    check('todo-1')
    sleep 0.5
    check('todo-2')
    sleep 0.5

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
  end

  scenario "Change the counter of tasks, check them and re-count", :js => true do
    title = 'Task to do'
    create_todo(title)
    title = 'Task to do2'
    create_todo(title)
    title = 'Task to do3'
    create_todo(title)

    check('todo-1')
    sleep 0.5
    check('todo-2')
    sleep 0.5

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
    sleep 0.5

    page.execute_script("$('#clean-up').trigger('click');")

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
    sleep 0.5
  end

end
