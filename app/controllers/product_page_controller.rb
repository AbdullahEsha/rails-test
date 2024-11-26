class ProductPageController < ApplicationController
  before_action :authenticate_user, except: [:index]

  def index
    @products = Product.all
  rescue StandardError => e
    flash[:alert] = t('errors.products.index')
    redirect_to root_path
  end

  def show
    @product = Product.find(params[:id])
    @related_products = @product.category.products.where.not(id: @product.id).limit(4)
    @reviews = @product.reviews.includes(:user)
  rescue ActiveRecord::RecordNotFound => e
    flash[:alert] = t('errors.products.not_found')
    redirect_to productpage_index_path
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = t('success.products.created')
      redirect_to productpage_show_path(@product)
    else
      render :new
    end
  rescue StandardError => e
    flash.now[:alert] = t('errors.products.create')
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = t('success.products.updated')
      redirect_to productpage_show_path(@product)
    else
      render :edit
    end
  rescue ActiveRecord::RecordNotFound => e
    flash[:alert] = t('errors.products.not_found')
    redirect_to productpage_index_path
  rescue StandardError => e
    flash.now[:alert] = t('errors.products.update')
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = t('success.products.deleted')
    redirect_to productpage_index_path
  rescue ActiveRecord::RecordNotFound => e
    flash[:alert] = t('errors.products.not_found')
    redirect_to productpage_index_path
  rescue StandardError => e
    flash.now[:alert] = t('errors.products.destroy')
  end

  private

  def authenticate_user
    redirect_to login_path, alert: t('errors.authentication.required') unless current_user
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_quantity, :category_id)
  end
end