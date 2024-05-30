require "application_system_test_case"

class DamagedItemsTest < ApplicationSystemTestCase
  setup do
    @damaged_item = damaged_items(:one)
  end

  test "visiting the index" do
    visit damaged_items_url
    assert_selector "h1", text: "Damaged Items"
  end

  test "creating a Damaged item" do
    visit damaged_items_url
    click_on "New Damaged Item"

    fill_in "Claim", with: @damaged_item.claim_id
    fill_in "Estimated value", with: @damaged_item.estimated_value
    fill_in "Item name", with: @damaged_item.item_name
    fill_in "Serial number", with: @damaged_item.serial_number
    click_on "Create Damaged item"

    assert_text "Damaged item was successfully created"
    assert_selector "h1", text: "Damaged Items"
  end

  test "updating a Damaged item" do
    visit damaged_item_url(@damaged_item)
    click_on "Edit", match: :first

    fill_in "Claim", with: @damaged_item.claim_id
    fill_in "Estimated value", with: @damaged_item.estimated_value
    fill_in "Item name", with: @damaged_item.item_name
    fill_in "Serial number", with: @damaged_item.serial_number
    click_on "Update Damaged item"

    assert_text "Damaged item was successfully updated"
    assert_selector "h1", text: "Damaged Items"
  end

  test "destroying a Damaged item" do
    visit edit_damaged_item_url(@damaged_item)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Damaged item was successfully destroyed"
  end
end
