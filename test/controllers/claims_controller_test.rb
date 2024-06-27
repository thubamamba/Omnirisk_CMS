require "test_helper"

class ClaimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim = claims(:one)
  end

  test "should get index" do
    get claims_url
    assert_response :success
  end

  test "should get new" do
    get new_claim_url
    assert_response :success
  end

  test "should create claim" do
    assert_difference("Claim.count") do
      post claims_url, params: {claim: {claim_number: @claim.claim_number, claim_type: @claim.claim_type, date_of_loss: @claim.date_of_loss, description_of_incident: @claim.description_of_incident, incident_location: @claim.incident_location, insured_property_ownership: @claim.insured_property_ownership, municipality_id: @claim.municipality_id, nature_of_incident: @claim.nature_of_incident, police_ref_number: @claim.police_ref_number, police_station_incident_reported_to: @claim.police_station_incident_reported_to, status: @claim.status, type_of_property_loss: @claim.type_of_property_loss}}
    end

    assert_redirected_to claim_url(Claim.last)
  end

  test "should show claim" do
    get claim_url(@claim)
    assert_response :success
  end

  test "should get edit" do
    get edit_claim_url(@claim)
    assert_response :success
  end

  test "should update claim" do
    patch claim_url(@claim), params: {claim: {claim_number: @claim.claim_number, claim_type: @claim.claim_type, date_of_loss: @claim.date_of_loss, description_of_incident: @claim.description_of_incident, incident_location: @claim.incident_location, insured_property_ownership: @claim.insured_property_ownership, municipality_id: @claim.municipality_id, nature_of_incident: @claim.nature_of_incident, police_ref_number: @claim.police_ref_number, police_station_incident_reported_to: @claim.police_station_incident_reported_to, status: @claim.status, type_of_property_loss: @claim.type_of_property_loss}}
    assert_redirected_to claim_url(@claim)
  end

  test "should destroy claim" do
    assert_difference("Claim.count", -1) do
      delete claim_url(@claim)
    end

    assert_redirected_to claims_url
  end
end
