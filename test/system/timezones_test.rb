require "application_system_test_case"

class TimezonesTest < ApplicationSystemTestCase
  setup do
    @timezone = timezones(:one)
  end

  test "visiting the index" do
    visit timezones_url
    assert_selector "h1", text: "Timezones"
  end

  test "creating a Timezone" do
    visit timezones_url
    click_on "New Timezone"

    fill_in "Abbr", with: @timezone.abbr
    check "Isdst" if @timezone.isdst
    fill_in "Offset", with: @timezone.offset
    fill_in "Text", with: @timezone.text
    fill_in "Utc", with: @timezone.utc
    fill_in "Value", with: @timezone.value
    click_on "Create Timezone"

    assert_text "Timezone was successfully created"
    click_on "Back"
  end

  test "updating a Timezone" do
    visit timezones_url
    click_on "Edit", match: :first

    fill_in "Abbr", with: @timezone.abbr
    check "Isdst" if @timezone.isdst
    fill_in "Offset", with: @timezone.offset
    fill_in "Text", with: @timezone.text
    fill_in "Utc", with: @timezone.utc
    fill_in "Value", with: @timezone.value
    click_on "Update Timezone"

    assert_text "Timezone was successfully updated"
    click_on "Back"
  end

  test "destroying a Timezone" do
    visit timezones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Timezone was successfully destroyed"
  end
end
