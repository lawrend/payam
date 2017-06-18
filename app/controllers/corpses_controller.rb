class CorpsesController < ApplicationController
  before_action :set_corpse, only: [:show, :edit, :update, :destroy]

	def index
    #only displays corpses that are completed
    if params[:style_id]
      @corpses = Corpse.completed.where(:style_id => params[:style_id])
    else
		  @corpses = Corpse.completed
    end
	end

	def new
    #remove styles that do not refer to corpses
    clean_styles
		@corpse = Corpse.new
    @line = Line.new
    @style = Style.new
	end

	def create
    @corpse = Corpse.new(corpse_params)
    #check for both selection from dropdown and new entry in text field
    if style_check
      render :new
    elsif @corpse.valid?
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
        #set current_scribe to nil so it goes to no one and the corpse is scoped to completed
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
		params.require(:corpse).permit(:style_id, :counter, :title, :current_scribe, lines_attributes: [:text, :auth_id, :count, :corpse_id], style_attributes: [:name])
  end

  def style_check
    if !corpse_params[:style_id].blank? && !corpse_params[:style_attributes][:name].blank?
      @corpse.errors.add(:style, "must be selected or created--not both")
    elsif corpse_params[:style_id].blank? && corpse_params[:style_attributes][:name].blank?
      @style = Style.new
    end
  end

  def clean_styles
    Style.all.each do |style|
      style.delete if style.corpses.empty? && style.protected == false
    end
  end

end
