class CorpsesController < ApplicationController
  before_action :set_corpse, only: [:show, :edit, :update, :destroy]
  before_action :check_word_count, only: [:create, :update]

	def index
		@corpses = Corpse.all
	end

	def new
		@corpse = Corpse.new
	end

	def create
		@corpse = Corpse.create(corpse_params)
    @corpse.counter += 1
    @corpse.current_scribe = User.all.sample.id
    @corpse.save
		redirect_to root_path
	end

	def show
	end

	def edit
	end

	def update
		if @corpse.update(corpse_params)
      if @corpse.counter < 8
        @corpse.counter += 1
        @corpse.current_scribe = User.all.sample.id
        @corpse.save
      else
        @corpse.current_scribe = nil
        @corpse.save
      end
			redirect_to root_path
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
		params.require(:corpse).permit(:style_id, :counter, lines_attributes: [:text, :auth_id, :count, :corpse_id])
  end

  def check_word_count
    @check_line = params[:corpse][:lines_attributes]['0'][:text]
    @check_new = params[:corpse][:lines_attributes]['0'][:corpse_id]
    if @check_line.scan(/[[:alpha:]]+/).count < 10
      flash[:alert] = "That's too few words"
      if @check_new.empty?
        redirect_to new_corpse_path
      else
        redirect_to edit_corpse_path(params[:id])
      end
    elsif @check_line.scan(/[[:alpha:]]+/).count > 20
      flash[:alert] = "That's too many words"
      if @check_new.empty?
        redirect_to new_corpse_path
      else
        redirect_to edit_corpse_path(params[:id])
      end
    end
  end
end
