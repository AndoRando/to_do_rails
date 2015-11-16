require 'rails_helper'

describe 'adding a new list' do
  it 'creates a new list' do
    visit lists_path
    click_on 'New List'
    fill_in 'Name', with: 'Test List'
    click_on 'Create List'
    expect(page).to have_content 'Test List'
  end

  it 'gives errors when missing required info' do
    visit lists_path
    click_on 'New List'
    click_on 'Create List'
    expect(page).to have_content 'Please fix'
  end
end

describe 'editing a list' do
  it 'edits an existing list' do
    test_list = List.create(name: 'Test List')
    visit list_path(test_list)
    click_on 'Edit list'
    fill_in 'Name', with: 'Another List'
    click_on 'Update List'
    expect(page).to have_content 'Another List'
  end

  it 'gives errors when missing required info' do
    test_list = List.create(name: 'Test List')
    visit list_path(test_list)
    click_on 'Edit list'
    fill_in 'Name', with: ''
    click_on 'Update List'
    expect(page).to have_content 'Please fix'
  end
end

describe 'deleting a list' do
  it 'deletes a list' do
    test_list = List.create(name: 'Test List')
    visit list_path(test_list)
    click_on 'Delete list'
    expect(page).not_to have_content 'Test List'
  end

  it 'deletes all related tasks' do
    test_list = List.create(name: 'Test List')
    test_task = test_list.tasks.create(description: 'Test task')
    visit list_path(test_list)
    click_on 'Delete list'
    expect(Task.any?).to eql false
  end
end
