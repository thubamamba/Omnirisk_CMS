require "test_helper"

class DamagedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @damaged_item = damaged_items(:one)
  end

  test "should get index" do
    get damaged_items_url
    assert_response :success
  end

  test "should get new" do
    get new_damaged_item_url
    assert_response :success
  end

  test "should create damaged_item" do
    assert_difference("DamagedItem.count") do
      post damaged_items_url, params: {damaged_item: {claim_id: @damaged_item.claim_id, estimated_value: @damaged_item.estimated_value, item_name: @damaged_item.item_name, serial_number: @damaged_item.serial_number}}
    end

    assert_redirected_to damaged_item_url(DamagedItem.last)
  end

  test "should show damaged_item" do
    get damaged_item_url(@damaged_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_damaged_item_url(@damaged_item)
    assert_response :success
  end

  test "should update damaged_item" do
    patch damaged_item_url(@damaged_item), params: {damaged_item: {claim_id: @damaged_item.claim_id, estimated_value: @damaged_item.estimated_value, item_name: @damaged_item.item_name, serial_number: @damaged_item.serial_number}}
    assert_redirected_to damaged_item_url(@damaged_item)
  end

  test "should destroy damaged_item" do
    assert_difference("DamagedItem.count", -1) do
      delete damaged_item_url(@damaged_item)
    end

    assert_redirected_to damaged_items_url
  end
end
