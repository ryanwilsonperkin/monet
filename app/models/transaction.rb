class Transaction < ApplicationRecord
  belongs_to :credit_card_statement
  belongs_to :vendor, optional: true

  before_create :auto_assign_vendor!

  delegate :name, to: :vendor, prefix: true, allow_nil: true
  delegate :category, to: :vendor, prefix: true, allow_nil: true

  private

  def auto_assign_vendor!
    return if vendor_id

    other = Transaction
      .where(description: description)
      .where.not(vendor_id: nil)
      .first
    return unless other

    self.vendor_id = other.vendor_id
  end
end
