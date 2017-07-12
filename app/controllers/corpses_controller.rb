class CorpsesController < ApplicationController
  before_action :set_corpse, only: [:show, :edit, :update, :destroy, :decompose]

	def index
    #only display corpses of a particular style that are completed
    if params[:style_id]
      @corpses = Corpse.completed.where(:style_id => params[:style_id])
    else
      #or all completed
		  @corpses = Corpse.completed
    end
    #everything else
    @all_other_corpses = Corpse.all - Corpse.completed
	end

	def new
    #remove orphaned custom styles
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
      #randomly select the next scribe
      @corpse.current_scribe = User.where.not(id: current_user.id).sample.id
      #send_to_next increases counter by 1 and saves
      @corpse.send_to_next
  		redirect_to root_path
    else
      @style = Style.new(:name => corpse_params[:style_attributes][:name])
      render :new
    end
	end

	def show
	end

  def decompose
    @corpse.lines.each do |line|
      line.lose_word
    end
    redirect_to corpse_path(@corpse)
  end

	def edit
      @line = Line.new
	end

	def update
		if @corpse.update(corpse_params)
      if @corpse.counter < 8
        #select next user and increase counter by 1
        @corpse.current_scribe = User.where.not(id: current_user.id).sample.id
        @corpse.send_to_next
      else
        #set current_scribe to nil so it goes to no one and the corpse is scoped to completed
        @corpse.current_scribe = nil
        @corpse.save
      end
			redirect_to root_path
    else
      @line = Line.new(:text => corpse_params[:lines_attributes]["0"][:text])
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
      @corpse.style_id = corpse_params[:style_id]
      @style = Style.new(:name => corpse_params[:style_attributes][:name])
      @corpse.errors.add(:style, "must be selected or created--not both")
    #elsif corpse_params[:style_id].blank? && corpse_params[:style_attributes][:name].blank?
    #  @corpse.errors.add(:style, "add a style, ya goof")
    #  @style = Style.new
    end
  end

  def clean_styles
    Style.all.each do |style|
      style.delete if style.corpses.empty? && style.protected == false
    end
  end

end
