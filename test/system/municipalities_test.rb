require "application_system_test_case"

class MunicipalitiesTest < ApplicationSystemTestCase
  setup do
    @municipality = municipalities(:one)
  end

  test "visiting the index" do
    visit municipalities_url
    assert_selector "h1", text: "Municipalities"
  end

  test "creating a Municipality" do
    visit municipalities_url
    click_on "New Municipality"

    fill_in "Account", with: @municipality.account_id
    check "Is active" if @municipality.is_active
    fill_in "Name", with: @municipality.name
    click_on "Create Municipality"

    assert_text "Municipality was successfully created"
    assert_selector "h1", text: "Municipalities"
  end

  test "updating a Municipality" do
    visit municipality_url(@municipality)
    click_on "Edit", match: :first

    fill_in "Account", with: @municipality.account_id
    check "Is active" if @municipality.is_active
    fill_in "Name", with: @municipality.name
    click_on "Update Municipality"

    assert_text "Municipality was successfully updated"
    assert_selector "h1", text: "Municipalities"
  end

  test "destroying a Municipality" do
    visit edit_municipality_url(@municipality)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Municipality was successfully destroyed"
  end
end
