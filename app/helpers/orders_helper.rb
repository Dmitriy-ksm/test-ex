module OrdersHelper

    def check_if_order_empty(order)
        order.orders_descriptions.nil? || order.orders_descriptions.empty?
    end

    def current_order(order, emptyOrderText)
        is_empty_order = check_if_order_empty(order)
        if(!is_empty_order)
            render partial: "order", locals: { order: order}
        else
            render plain: emptyOrderText
        end
        #"You dont have any items in your current order"
    end

    def order_history(orders)
        is_empty_orders = orders.nil? || orders.empty?
        results = []
        if(is_empty_orders)
            return "You do not have an order history, make your first purchase and here you can find out its details"
        else 
            orders.each do |order| 
                results << current_order(order, "Empty order").html_safe
            end
        end
        results
    end
end
