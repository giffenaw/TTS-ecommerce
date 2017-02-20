class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_filter :categories, :brands
  
  def line_items
    @line_items = LineItem.all
  end
  
  def categories
    @categories = Category.all
  end
  
  def brands
    @brands = Product.pluck(:brand).sort.uniq!
    if @brands == nil
      @brands = Product.pluck(:brand).sort
    end
      
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end