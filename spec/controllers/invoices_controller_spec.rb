require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  let!(:borrower) { create(:borrower) }
  let!(:invoice1) { create(:invoice, borrower: borrower) }
  let!(:invoice2) { create(:invoice, borrower: borrower) }

  describe 'GET #index' do
    before { get :index }

    it 'returns all invoices' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: invoice1.id } }

    it 'returns the invoice' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(invoice1.id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { invoice: { number: 'INV123', amount: 1000.0, due_date: Date.today + 30.days, borrower_id: borrower.id } } }

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a invoice' do
        expect(json['number']).to eq('INV123')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post :create, params: { invoice: { amount: 1000.0 } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) { { invoice: { status: 'approved' } } }
    let(:invalid_attributes) { { invoice: { status: 'closed' } } }

    context 'for correct status' do
      before { put :update, params: { id: invoice1.id }.merge(valid_attributes) }

      it 'updates the record' do
        expect(json['status']).to eq('approved')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'for incorrect status' do
      before { put :update, params: { id: invoice2.id }.merge(invalid_attributes) }

      it 'returns error' do
        expect(json["error"]).to eq('Cannot close invoice unless it is purchased')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
