class ItemsController < ApplicationController
    def index
        @items = Item.all
    end

    # /items/1 GET
    def show
    end

    # /items/new GET
    def new 
    end 

    # /items/new POST
    def create
    end

    # /items/create GET
    def createGet
        p params
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
    end

    # /items/1 DELETE
    def destroy
    end

    private
    def items_params
        params.require(:item).permit(:name, :price, :description)
      end
end
