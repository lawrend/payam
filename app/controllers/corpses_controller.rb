class CorpsesController < ApplicationController
  before_action :set_corpse, only: [:show, :edit, :update, :destroy]

	def index
		@corpses = Corpse.all
	end

	def new
		@corpse = Corpse.new
    @line = Line.new
	end

	def create
    @corpse = Corpse.new(corpse_params)
    if @corpse.valid?
      @corpse.save
      @corpse.current_scribe = User.where.not(id: current_user.id).sample.id
      @corpse.send_to_next
  		redirect_to root_path
    else
      render :new
    end
	end

	def show
	end

	def edit
    @line = Line.new
	end

	def update
		if @corpse.update(corpse_params)
      if @corpse.counter < 8
        @corpse.current_scribe = User.where.not(id: current_user.id).sample.id
        @corpse.send_to_next
      else
        @corpse.current_scribe = nil
        @corpse.save
      end
			redirect_to root_path
    else
      render :edit
		end
	end

	def destroy
    @corpse.destroy
    flash[:notice] = "Payam Deleted!!"
    redirect_to root_path
	end

	private

    def set_corpse
    	@corpse = Corpse.find(params[:id])
    end

	def corpse_params
		params.require(:corpse).permit(:style_id, :counter, :title, lines_attributes: [:text, :auth_id, :count, :corpse_id])
  end

end
