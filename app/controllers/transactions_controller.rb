class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update]
  before_action :set_vendors, only: [:edit, :edit_vendors]

  # GET /transactions or /transactions.json
  def index
    @query = query
    @transactions = Transaction
      .includes(:vendor)
      .order(date: :desc)
      .where("description like ?", "%#{query}%")
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/1/edit
  def edit
  end

  # GET /transactions/edit_vendors
  def edit_vendors
    @descriptions = Transaction
      .where(vendor_id: nil)
      .group(:description)
      .order(:description)
      .count
  end

  # PATCH/PUT /transactions/update_vendors
  def update_vendors
    description = params.require(:description)
    vendor_name = params.require(:vendor_name)
    vendor = vendor_name.blank? ? nil : Vendor.find_or_create_by(name: vendor_name)
    respond_to do |format|
      if Transaction.where(description: description).update(vendor: vendor)
        format.html { redirect_to edit_vendors_transactions_path, notice: "Transactions were successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    vendor_name = params.require(:transaction)[:vendor_name]
    vendor = vendor_name.blank? ? nil : Vendor.find_or_create_by(name: vendor_name)
    respond_to do |format|
      if @transaction.update(vendor: vendor)
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

    def set_vendors
      @vendors = Vendor.order(:name)
    end
end
