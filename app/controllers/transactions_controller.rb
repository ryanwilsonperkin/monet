class TransactionsController < ApplicationController
  before_action :set_transaction, only: :show

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

  private
    def query
      params[:query]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
