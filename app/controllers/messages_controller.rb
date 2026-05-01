# :nodoc:
class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to messages_path, notice: "Message saved"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_path, notice: "Deleted"
  end

  def search
    if params[:keyword].present?
      @messages = Message.where("author LIKE ? OR text LIKE ?",
                                "%#{params[:keyword]}%",
                                "%#{params[:keyword]}%")
      render :index
    else
      redirect_to messages_path
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:author, :text)
  end
end
