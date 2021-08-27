require "test_helper"

class CreditCardStatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credit_card_statement = credit_card_statements(:one)
  end

  test "should get index" do
    get credit_card_statements_url
    assert_response :success
  end

  test "should get new" do
    get new_credit_card_statement_url
    assert_response :success
  end

  test "should create credit_card_statement" do
    assert_difference('CreditCardStatement.count') do
      post credit_card_statements_url, params: { credit_card_statement: { content: @credit_card_statement.content, month: @credit_card_statement.month, year: @credit_card_statement.year } }
    end

    assert_redirected_to credit_card_statement_url(CreditCardStatement.last)
  end

  test "should show credit_card_statement" do
    get credit_card_statement_url(@credit_card_statement)
    assert_response :success
  end

  test "should get edit" do
    get edit_credit_card_statement_url(@credit_card_statement)
    assert_response :success
  end

  test "should update credit_card_statement" do
    patch credit_card_statement_url(@credit_card_statement), params: { credit_card_statement: { content: @credit_card_statement.content, month: @credit_card_statement.month, year: @credit_card_statement.year } }
    assert_redirected_to credit_card_statement_url(@credit_card_statement)
  end

  test "should destroy credit_card_statement" do
    assert_difference('CreditCardStatement.count', -1) do
      delete credit_card_statement_url(@credit_card_statement)
    end

    assert_redirected_to credit_card_statements_url
  end
end
