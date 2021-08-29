class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update]

  # GET /transactions or /transactions.json
  def index
    @query = query
    @transactions = Transaction
      .includes(:vendor)
      .where("description like ?", "%#{query}%")
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/1/edit
  def edit
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    transaction_params = params.require(:transaction).permit(:vendor_id)
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def query
      params[:query]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
