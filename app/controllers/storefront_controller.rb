class StorefrontController < ApplicationController
  def all_items
    @product = Product.all
  end

  def items_by_category
    @category = Category.find(params[:cat_id]) # finding our categories by our category IDs.
    @products = Product.all # defining all products
    @products_by_category = [] # an empty array
    
    @products.each do |product| #for each product with an id, we add tahat product to our array
      if product.category.id == params[:cat_id].to_i
        @products_by_category.push(product)
      end
    end
  end

  def items_by_brand
    @brand_name = params[:brand]
    @products = Product.all
    @products_by_brand = []
    
    @products.each do |product|
      if product.brand == params[:brand]
        @products_by_brand.push(product)
      end
    end
  end
  
end
