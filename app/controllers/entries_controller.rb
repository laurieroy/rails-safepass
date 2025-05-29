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
      flash.now[:notice] = "<strong>#{entry.name}</strong> has been saved!"
      html_safe
      respond_to do |format|
        format.html {redirect_to root_path}
        format.turbo_stream {}
      end
      
    else
      render :new, status: :unprocessable_entity
    end
  end

end

private

def entry_params
  params.expect(entry: [:name, :url, :username, :password])
end