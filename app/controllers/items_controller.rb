class ItemsController < ApplicationController
    
    #before_filter :find_item, only: [:show, :edit, :update, :destroy]
    before_action  :find_item, only: [:show, :edit, :update, :destroy, :buy]
    before_action  :check_if_admin, only: [:edit, :update, :new, :create, :destroy]
    before_action :is_login, only: [:buy]

    def index
        @is_admin = if_admin_boolean
        @is_login = is_login
        @descOrAsc = params[:price_sort] == "1" ? "DESC" : "ASC";
        @items = Item
        @items = @items.where("price >= ?", params[:price_from])    if params[:price_from]
        @items = @items.where("price <= ?", params[:price_to])      if params[:price_to]
        @items = @items.order("price #{@descOrAsc}", "price") 
    end

    # /items/1 GET
    def show
        unless @item
            render plain: "Page not found", status: 404
        #if @item = Item.where(id: params[:id]).first
        #    render "items/show"
        #else 
        #    render plain: "Page not found", status: 404
        end
    end

    # /items/new GET
    def new 
        @item = Item.new
    end 

    # /items POST
    def create
        @item = Item.create(items_params)
        if @item.errors.empty?
            redirect_to item_path(@item)
        else
            render "new"
        end
    end

    # /items/create GET
    def createGet
        @item = Item.create(items_params)
        # ActiveModel::ForbiddenAttributesError
        #@item = Item.create(params[:item])
        #Не нужен permit для нижней строки
        #@item = Item.create(name: params[:name], description: params[:description], price: params[:price])
        render plain: "create #{@item.id}: #{@item.name} (#{!@item.new_record?})"
    end

    # /items/1/edit GET
    def edit
    end

    # /items/1 PUT
    def update
        @item.update(items_params)
        if @item.errors.empty?
            redirect_to item_path(@item)
        else
            render "edit"
        end
    end

    # /items/1 DELETE
    def destroy
        @item.destroy
        redirect_to action: "index"
    end

    def buy
        #Order logic here
        #Получает текущий заказ пользователя
        @lastOrder = current_user.orders.last
        #Логика если первый заказ
        @lastOrder = Order.create if @lastOrder.nil?
        current_user.orders << @lastOrder if @lastOrder.new_record?
        
        count = params[:item][:count].to_f
        itemId = params[:id]
        render_404 if itemId.nil?
        item = Item.find(itemId);
        render_404 if item.nil?
        price = item.price 
        cur_amount = price.nil? || count.nil? ? 0 : price*count
        position = OrdersDescription.create(:item_id => itemId, :quantity => count, :order_id =>  @lastOrder.id)
        @lastOrder.amount = @lastOrder.amount.nil? ? cur_amount : cur_amount + @lastOrder.amount
        @lastOrder.save
        
        redirect_to action: "index"
    end

    private
        def items_params
            params.require(:item).permit(:name, :price, :description)
        end

        def find_item
            @item = Item.where(id: params[:id]).first
            render_404 unless @item
        end
end
