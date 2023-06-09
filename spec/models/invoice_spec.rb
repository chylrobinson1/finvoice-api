# spec/models/invoice_spec.rb
require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let!(:borrower) { create(:borrower) }
  let!(:invoice) { create(:invoice, borrower: borrower) }

  it 'should be valid' do
    expect(invoice).to be_valid
  end

  it 'number should be present' do
    invoice.number = ''
    expect(invoice).not_to be_valid
  end
end