require 'rails_helper'

describe 'adding a task to a list' do
  it 'adds a task to a list' do
    test_list = List.create(name: 'Test List')
    visit list_path(test_list)
    click_on 'Add a task'
    fill_in 'Description', with: 'Test task'
    click_on 'Create Task'
    expect(page).to have_content 'Test task'
  end

  it 'gives errors when missing required info' do
    test_list = List.create(name: 'Test List')
    visit list_path(test_list)
    click_on 'Add a task'
    click_on 'Create Task'
    expect(page).to have_content 'Please fix'
  end
end

describe 'editing a task' do
  it 'edits a task' do
    test_list = List.create(name: 'Test List')
    test_task = test_list.tasks.create(description: 'Test task')
    visit list_path(test_list)
    click_on 'Edit task'
    fill_in 'Description', with: 'Another task'
    click_on 'Update Task'
    expect(page).to have_content 'Another task'
  end

  it 'gives errors when missing required info' do
    test_list = List.create(name: 'Test List')
    test_task = test_list.tasks.create(description: 'Test task')
    visit list_path(test_list)
    click_on 'Edit task'
    fill_in 'Description', with: ''
    click_on 'Update Task'
    expect(page).to have_content 'Please fix'
  end
end

describe 'deleting a task' do
  it 'deletes a task' do
    test_list = List.create(name: 'Test List')
    test_task = test_list.tasks.create(description: 'Test task')
    visit list_path(test_list)
    click_on 'Delete task'
    expect(page).not_to have_content 'Test task'
  end
end
