require "application_system_test_case"

class MtypesTest < ApplicationSystemTestCase
  setup do
    @mtype = mtypes(:one)
  end

  test "visiting the index" do
    visit mtypes_url
    assert_selector "h1", text: "Mtypes"
  end

  test "should create mtype" do
    visit mtypes_url
    click_on "New mtype"

    fill_in "Name", with: @mtype.name
    click_on "Create Mtype"

    assert_text "Mtype was successfully created"
    click_on "Back"
  end

  test "should update Mtype" do
    visit mtype_url(@mtype)
    click_on "Edit this mtype", match: :first

    fill_in "Name", with: @mtype.name
    click_on "Update Mtype"

    assert_text "Mtype was successfully updated"
    click_on "Back"
  end

  test "should destroy Mtype" do
    visit mtype_url(@mtype)
    click_on "Destroy this mtype", match: :first

    assert_text "Mtype was successfully destroyed"
  end
end
