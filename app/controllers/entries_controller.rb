class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries
    @main_entry = current_user.entries.first
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      flash[:notice] = "Entry has been saved!"
      respond_to do |format|
        format.html {redirect_to root_path}
        format.turbo_stream {}
      end
      
    else
      flash[:alert] = "Sorry, there was an issue"
      render :new, status: :unprocessable_entity
    end
  end

end

private

def entry_params
  params.expect(entry: [:name, :url, :username, :password])
end