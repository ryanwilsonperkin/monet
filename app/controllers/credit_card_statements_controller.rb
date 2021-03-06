class CreditCardStatementsController < ApplicationController
  before_action :set_credit_card_statement, only: %i[ show edit update destroy ]

  # GET /credit_card_statements or /credit_card_statements.json
  def index
    @credit_card_statements = CreditCardStatement.all
  end

  # GET /credit_card_statements/1 or /credit_card_statements/1.json
  def show
  end

  # GET /credit_card_statements/new
  def new
    @credit_card_statement = CreditCardStatement.new
  end

  # POST /credit_card_statements or /credit_card_statements.json
  def create
    @credit_card_statement = CreditCardStatement.new(credit_card_statement_params)

    respond_to do |format|
      if @credit_card_statement.save
        format.html { redirect_to @credit_card_statement, notice: "Credit card statement was successfully created." }
        format.json { render :show, status: :created, location: @credit_card_statement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit_card_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_card_statements/1 or /credit_card_statements/1.json
  def destroy
    @credit_card_statement.destroy
    respond_to do |format|
      format.html { redirect_to credit_card_statements_url, notice: "Credit card statement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card_statement
      @credit_card_statement = CreditCardStatement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def credit_card_statement_params
      content_file = params.require(:credit_card_statement).require(:content_file)
      { content: content_file.read.force_encoding("UTF-8") }
    end
end
