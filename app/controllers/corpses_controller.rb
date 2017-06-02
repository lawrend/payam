class CorpsesController < ApplicationController
  before_action :set_corpse, only: [:show, :edit, :update, :destroy]

	def index
		@corpses = Corpse.all
	end

	def new
		@corpse = Corpse.new
	end

	def create
		@corpse = Corpse.create(corpse_params)
		redirect_to root_path
	end

	def show
	end

	def edit
	end

	def update
		if @corpse.update(corpse_params)
      @corpse.counter += 1
			redirect_to root_path
		end
	end

	def destroy
	end

	private

    def set_corpse
    	@corpse = Corpse.find(params[:id])
    end

	def corpse_params
		params.require(:corpse).permit(:style_id, :counter, lines_attributes: [:text, :auth_id, :count])
  end
end
