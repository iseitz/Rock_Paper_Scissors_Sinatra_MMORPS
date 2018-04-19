require "spec_helper"

feature "user choses rock, paper and scissors on the main page of the game by clicking the buttons" do
  scenario "click rock button" do
    visit "/"
    click_button 'rock'
    expect(page).to have_content("Player")
    expect(page).to have_content("Score")
    expect(page).to have_content("Human")
    expect(page).to have_content("Computer")
    expect(page).to have_content("Player")
    expect(page).to have_content("chose rock")
  end

  scenario "click rock button" do
    visit "/"
    click_button 'paper'
    expect(page).to have_content("Player")
    expect(page).to have_content("Score")
    expect(page).to have_content("Human")
    expect(page).to have_content("Computer")
    expect(page).to have_content("Player")
    expect(page).to have_content("chose paper")
  end

  scenario "click rock button" do
    visit "/"
    click_button 'scissors'
    expect(page).to have_content("Player")
    expect(page).to have_content("Score")
    expect(page).to have_content("Human")
    expect(page).to have_content("Computer")
    expect(page).to have_content("Player")
    expect(page).to have_content("chose scissors")
  end
end
