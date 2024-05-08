require "application_system_test_case"

class ClaimsTest < ApplicationSystemTestCase
  setup do
    @claim = claims(:one)
  end

  test "visiting the index" do
    visit claims_url
    assert_selector "h1", text: "Claims"
  end

  test "creating a Claim" do
    visit claims_url
    click_on "New Claim"

    fill_in "Claim number", with: @claim.claim_number
    fill_in "Claim type", with: @claim.claim_type
    fill_in "Date of loss", with: @claim.date_of_loss
    fill_in "Description of incident", with: @claim.description_of_incident
    fill_in "Incident location", with: @claim.incident_location
    fill_in "Insured property ownership", with: @claim.insured_property_ownership
    fill_in "Municipality", with: @claim.municipality_id
    fill_in "Nature of incident", with: @claim.nature_of_incident
    fill_in "Police ref number", with: @claim.police_ref_number
    fill_in "Police station incident reported to", with: @claim.police_station_incident_reported_to
    fill_in "Status", with: @claim.status
    fill_in "Type of property loss", with: @claim.type_of_property_loss
    click_on "Create Claim"

    assert_text "Claim was successfully created"
    assert_selector "h1", text: "Claims"
  end

  test "updating a Claim" do
    visit claim_url(@claim)
    click_on "Edit", match: :first

    fill_in "Claim number", with: @claim.claim_number
    fill_in "Claim type", with: @claim.claim_type
    fill_in "Date of loss", with: @claim.date_of_loss
    fill_in "Description of incident", with: @claim.description_of_incident
    fill_in "Incident location", with: @claim.incident_location
    fill_in "Insured property ownership", with: @claim.insured_property_ownership
    fill_in "Municipality", with: @claim.municipality_id
    fill_in "Nature of incident", with: @claim.nature_of_incident
    fill_in "Police ref number", with: @claim.police_ref_number
    fill_in "Police station incident reported to", with: @claim.police_station_incident_reported_to
    fill_in "Status", with: @claim.status
    fill_in "Type of property loss", with: @claim.type_of_property_loss
    click_on "Update Claim"

    assert_text "Claim was successfully updated"
    assert_selector "h1", text: "Claims"
  end

  test "destroying a Claim" do
    visit edit_claim_url(@claim)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Claim was successfully destroyed"
  end
end
