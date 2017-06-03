class LinesController < ApplicationController

  def new
    @line = Line.new
  end

  def create
    @line = Line.create(line_params)
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  private

  def set_line
    @line = Line.find(:id)
  end

  def line_params
    params.require(:line).permit(:text, :count, :auth_id, :corpse_id, :auth_public)
  end

end
