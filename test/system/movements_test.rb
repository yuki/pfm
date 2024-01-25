require "application_system_test_case"

class MovementsTest < ApplicationSystemTestCase
  setup do
    @movement = movements(:one)
  end

  test "visiting the index" do
    visit movements_url
    assert_selector "h1", text: "Movements"
  end

  test "should create movement" do
    visit movements_url
    click_on "New movement"

    fill_in "Account amount", with: @movement.account_amount
    fill_in "Amount", with: @movement.amount
    fill_in "Description", with: @movement.description
    check "Is transfer" if @movement.is_transfer
    fill_in "Mdate", with: @movement.mdate
    fill_in "Movement", with: @movement.movement_id
    fill_in "Name", with: @movement.name
    click_on "Create Movement"

    assert_text "Movement was successfully created"
    click_on "Back"
  end

  test "should update Movement" do
    visit movement_url(@movement)
    click_on "Edit this movement", match: :first

    fill_in "Account amount", with: @movement.account_amount
    fill_in "Amount", with: @movement.amount
    fill_in "Description", with: @movement.description
    check "Is transfer" if @movement.is_transfer
    fill_in "Mdate", with: @movement.mdate
    fill_in "Movement", with: @movement.movement_id
    fill_in "Name", with: @movement.name
    click_on "Update Movement"

    assert_text "Movement was successfully updated"
    click_on "Back"
  end

  test "should destroy Movement" do
    visit movement_url(@movement)
    click_on "Destroy this movement", match: :first

    assert_text "Movement was successfully destroyed"
  end
end
