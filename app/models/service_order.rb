class ServiceOrder < ApplicationRecord
  belongs_to :transport_model, optional: true
  belongs_to :vehicle, optional: true
  belongs_to :customer
  has_one :product
  accepts_nested_attributes_for :customer, :product

  enum service_order_status: { pending: 0, processed: 5, delivered: 10 }

  validates :pickup_address, :pickup_cep, :delivery_distance, presence: true
  validates :delivery_distance, numericality: { greater_than_or_equal_to: 0 }
  validates :pickup_cep, length: { is: 8 }
  validates :pickup_cep, numericality: { only_integer: true }

  before_create :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
