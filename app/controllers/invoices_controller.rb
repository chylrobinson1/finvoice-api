class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:update, :show]

  # GET /invoices
  def index
    @invoices = Invoice.includes(:borrower).all
    render json: @invoices.as_json(include: :borrower)
  end

  # GET /invoices/:id
  def show
    render json: @invoice
  end

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      render json: @invoice.as_json(include: :borrower), status: :created, location: @invoice
    else
      render json: { error: @invoice.errors }, status: :unprocessable_entity
      # render json: { error: @invoice.errors.full_messages.join('\n') }, status: :unprocessable_entity
    end
  end

  # PUT /invoices/:id
  def update
    if invoice_params[:status]
      if invoice_params[:status] == 'purchased' && @invoice.status != :approved
        render json: { error: 'Cannot purchase invoice unless it is approved' }, status: :unprocessable_entity
        return
      elsif invoice_params[:status] == 'closed' && @invoice.status != :purchased
        render json: { error: 'Cannot close invoice unless it is purchased' }, status: :unprocessable_entity
        return
      end
    end

    if !@invoice.update(invoice_params)
      render json: { error: @invoice.errors.full_messages }, status: :unprocessable_entity
      return
    end

    render json: @invoice.as_json(include: :borrower)
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:number, :amount, :due_date, :borrower_id, :status, :fees_accrued)
  end
end
