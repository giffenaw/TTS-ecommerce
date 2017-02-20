class CartController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]
  
  def checkout
    @line_items = LineItem.all
    @order = Order.new
    @order.user_id = current_user.user_id
    
    sum = 0
    
    if @line_items.empty?
      redirect_to root_path
    else
    
      @line_items.each do |line_item|
        if @order.order_items[line_item.product_id].nil?
          # if the line item doesn't exist yet, we stoere it into a hash
          @order.order_items[line_item.product_id] = line_item.quantity
        else
          # if the line item does exist, it gets added to the hash
          @order.order_items[line_item.product_id] = line_item.quantity
        end
        
        sum += line_item.line_item_total
      end
    end
      
      @order.subtotal = sum
      @order.sales_tax = sum * 0.08
      @order.grand_total = sum + @order.sales_tax
      @order.save
      
      @line_items.each do |line_item|
        line_item.product.quantity -= line_item.quantity
        line_item.product.save
      end
      
      LineItem.destroy_all
  end
  
  def add_to_cart
    line_item = LineItem.new
    line_item.product_id = params[:product_id]
    line_item.quantity = params[:quantity]
    
    if line_item.quantity.nil?
      flash[:alert] = "No quantity selected"
      redirect_to root_path
    else
      line_item.line_item_total = line_item.product.price * line_item.quantity
      line_item.save
      redirect_to view_order_path
    end
  end

  def view_order
    @line_items = LineItem.all
  end

  def order_complete

  end

end
