require "application_system_test_case"

class AvatorsTest < ApplicationSystemTestCase
  setup do
    @avator = avators(:one)
  end

  test "visiting the index" do
    visit avators_url
    assert_selector "h1", text: "Avators"
  end

  test "creating a Avator" do
    visit avators_url
    click_on "New Avator"

    fill_in "Uid", with: @avator.uid
    click_on "Create Avator"

    assert_text "Avator was successfully created"
    click_on "Back"
  end

  test "updating a Avator" do
    visit avators_url
    click_on "Edit", match: :first

    fill_in "Uid", with: @avator.uid
    click_on "Update Avator"

    assert_text "Avator was successfully updated"
    click_on "Back"
  end

  test "destroying a Avator" do
    visit avators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Avator was successfully destroyed"
  end
end
