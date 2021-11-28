class OrdersController < ApplicationController
    before_action :check_if_login
    before_action :check_orders

    def index
        @order_history = @orders[0..-2]
        @cur_order = @orders.last
    end

    def accept 
        @cur_order = @orders.last
        current_user.orders << Order.create unless check_if_order_empty(@cur_order)
        redirect_to action: "index"
    end

    def remove_position
        @cur_order = @orders.last

        order_descr = @cur_order.orders_descriptions.where(id: params[:orders_descriptions]).first
        render_404 if order_descr.nil?
        unless order_descr.nil?
            amount_to_subtract = (order_descr.item.price.nil? ? 0 : order_descr.item.price)  * order_descr.quantity
            order_descr.destroy
            @cur_order.amount = @cur_order.amount - amount_to_subtract
            @cur_order.save
            redirect_to action: "index"
        end
    end


    private

        def check_if_order_empty(order)
            order.orders_descriptions.nil? || order.orders_descriptions.empty?
        end

        def check_orders
            @orders = current_user.orders
            render file: "#{Rails.root}/public/no_order.html"   if (@orders.nil? || @orders.empty?) 
        end
end
