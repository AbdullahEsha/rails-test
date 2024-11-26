class HomePageController < ApplicationController
  def index
    @featured_products = Product.order(created_at: :desc).limit(4)
    @promotion_banner = {
      title: t('home.promotion.title'),
      description: t('home.promotion.description'),
      image_url: 'https://via.placeholder.com/1200x600'
    }
  rescue => e
    flash[:alert] = t('home.error')
    logger.error "Error fetching homepage data: #{e.message}"
    redirect_to root_path
  end

  private

  def home_params
    params.require(:home).permit(:hero_title, :hero_description)
  end
end