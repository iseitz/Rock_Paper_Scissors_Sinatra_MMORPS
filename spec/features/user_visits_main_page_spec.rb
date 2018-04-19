require "spec_helper"

feature "user views main page of the game" do
  scenario "view options" do
    visit "/"
    click_button 'rock'
    expect(page).to have_content("Player")
    expect(page).to have_content("Score")
    expect(page).to have_content("Human")
    expect(page).to have_content("Computer")
    expect(page).to have_content("Player")
    expect(page).to have_content("chose rock")
  end
end
