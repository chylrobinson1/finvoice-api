class Invoice < ApplicationRecord
  belongs_to :borrower

  enum status: { created: 0, rejected: 1, approved: 2, purchased: 3, closed: 4 }

  validates :number, :amount, :due_date, :status, presence: true
  validates :number, uniqueness: true
end
