class SkisController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @ski = Ski.new
  end

  def create
    # find user - move this to a before filter
    @user = User.find(params[:user_id])
    @ski = @user.ski.new(ski_params)
    if @ski.save!
      flash[:notice] = 'Ski successfully created!'
      redirect_to user_ski_path(@user, @ski)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @ski = Ski.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    @skis = @user.skis.all
  end

  private

  def ski_params
    params.require(:ski).permit(
      :brand,
      :model,
      :skate,
      :classic,
      :size
    )
  end
end
