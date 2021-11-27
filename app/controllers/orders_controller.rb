class OrdersController < ApplicationController
    before_action :check_login
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

    private

        def check_login
            render_403 unless is_login
        end

        def check_if_order_empty(order)
            order.orders_descriptions.nil? || order.orders_descriptions.empty?
        end

        def check_orders
            @orders = current_user.orders
            render file: "#{Rails.root}/public/no_order.html"   if (@orders.nil? || @orders.empty?) 
        end
end
