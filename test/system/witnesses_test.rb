require "application_system_test_case"

class WitnessesTest < ApplicationSystemTestCase
  setup do
    @witness = witnesses(:one)
  end

  test "visiting the index" do
    visit witnesses_url
    assert_selector "h1", text: "Witnesses"
  end

  test "creating a Witness" do
    visit witnesses_url
    click_on "New Witness"

    fill_in "Claim", with: @witness.claim_id
    fill_in "Witness contact number", with: @witness.witness_contact_number
    fill_in "Witness email", with: @witness.witness_email
    fill_in "Witness name", with: @witness.witness_name
    fill_in "Witness physical address", with: @witness.witness_physical_address
    fill_in "Witness prefix", with: @witness.witness_prefix
    click_on "Create Witness"

    assert_text "Witness was successfully created"
    assert_selector "h1", text: "Witnesses"
  end

  test "updating a Witness" do
    visit witness_url(@witness)
    click_on "Edit", match: :first

    fill_in "Claim", with: @witness.claim_id
    fill_in "Witness contact number", with: @witness.witness_contact_number
    fill_in "Witness email", with: @witness.witness_email
    fill_in "Witness name", with: @witness.witness_name
    fill_in "Witness physical address", with: @witness.witness_physical_address
    fill_in "Witness prefix", with: @witness.witness_prefix
    click_on "Update Witness"

    assert_text "Witness was successfully updated"
    assert_selector "h1", text: "Witnesses"
  end

  test "destroying a Witness" do
    visit edit_witness_url(@witness)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Witness was successfully destroyed"
  end
end
