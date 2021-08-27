require "application_system_test_case"

class CreditCardStatementsTest < ApplicationSystemTestCase
  setup do
    @credit_card_statement = credit_card_statements(:one)
  end

  test "visiting the index" do
    visit credit_card_statements_url
    assert_selector "h1", text: "Credit Card Statements"
  end

  test "creating a Credit card statement" do
    visit credit_card_statements_url
    click_on "New Credit Card Statement"

    fill_in "Content", with: @credit_card_statement.content
    fill_in "Month", with: @credit_card_statement.month
    fill_in "Year", with: @credit_card_statement.year
    click_on "Create Credit card statement"

    assert_text "Credit card statement was successfully created"
    click_on "Back"
  end

  test "updating a Credit card statement" do
    visit credit_card_statements_url
    click_on "Edit", match: :first

    fill_in "Content", with: @credit_card_statement.content
    fill_in "Month", with: @credit_card_statement.month
    fill_in "Year", with: @credit_card_statement.year
    click_on "Update Credit card statement"

    assert_text "Credit card statement was successfully updated"
    click_on "Back"
  end

  test "destroying a Credit card statement" do
    visit credit_card_statements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Credit card statement was successfully destroyed"
  end
end
