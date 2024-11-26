class AboutUsPageController < ApplicationController
  def index
    render :index
  end

  private

  def about_us_page_params
    params.require(:about_us_page).permit()
  end

  rescue_from Exception, with: :render_500_response

  def render_500_response(exception)
    logger.error(exception.message)
    render plain: t('errors.internal_server_error'), status: :internal_server_error
  end
end