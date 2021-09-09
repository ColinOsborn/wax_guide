class SkiBrandsController < ApplicationController

  def new
    @ski_brand = SkiBrand.new
  end

  def create
    @ski_brand = SkiBrand.create!(ski_brand_params)
    respond_to do |format|
    if @ski_brand.save!
      format.html { redirect_to portfolios_path, notice: "You've created a new ski brand!" }
    else
      format.html { render :new }
      end
    end
  end

  def index
    @ski_brands = SkiBrand.all
  end

  private

  def ski_brand_params
    params.require(:ski_brand).permit(:name,
                                      :subtitle,
                                      :body,
                                      :thumb_image,
                                      )
  end
end
