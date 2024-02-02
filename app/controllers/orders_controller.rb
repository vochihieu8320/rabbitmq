class OrdersController < ApplicationController
    def index
        Order.create({product_id: 1, price: 2000, quantity: 1})
    end
end
