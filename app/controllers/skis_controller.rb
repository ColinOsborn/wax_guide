class SkisController < ApplicationController
  before_action :find_user, only: %i[ new create show index ]

  def new
    @ski = Ski.new
  end

  def create
    @ski = @user.ski.new(ski_params)
    if @ski.save!
      flash[:notice] = 'Ski successfully created!'
      redirect_to user_ski_path(@user, @ski)
    else
      render :new
    end
  end

  def show
    @ski = Ski.find(params[:id])
  end

  def index
    @skis = @user.skis.all
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def ski_params
    params.require(:ski).permit(
      :brand,
      :model,
      :skate,
      :classic,
      :size,
      :grind,
    )
  end
end
