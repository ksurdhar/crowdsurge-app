class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = current_user.id
    if @ticket.save
      redirect_to ticket_url(@ticket)
    else
      flash.now[:errors] = @ticket.errors.full_messages
      render :new
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(ticket_params)
      redirect_to ticket_url(@ticket)
    else
      flash.now[:errors] = @ticket.errors.full_messages
      render :edit
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
    redirect_to tickets_url
  end

  private
  def ticket_params
    params.require(:ticket).permit(:event, :description)
  end
end
