require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @comment = comments(:one)
  end

  test "visiting the index" do
    visit comments_url
    assert_selector "h1", text: "Comments"
  end

  test "creating a Comment" do
    visit comments_url
    click_on "New Comment"

    fill_in "Claim", with: @comment.claim_id
    fill_in "Description", with: @comment.description
    check "Is active" if @comment.is_active
    check "Is verified" if @comment.is_verified
    fill_in "User", with: @comment.user_id
    click_on "Create Comment"

    assert_text "Comment was successfully created"
    assert_selector "h1", text: "Comments"
  end

  test "updating a Comment" do
    visit comment_url(@comment)
    click_on "Edit", match: :first

    fill_in "Claim", with: @comment.claim_id
    fill_in "Description", with: @comment.description
    check "Is active" if @comment.is_active
    check "Is verified" if @comment.is_verified
    fill_in "User", with: @comment.user_id
    click_on "Update Comment"

    assert_text "Comment was successfully updated"
    assert_selector "h1", text: "Comments"
  end

  test "destroying a Comment" do
    visit edit_comment_url(@comment)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Comment was successfully destroyed"
  end
end
