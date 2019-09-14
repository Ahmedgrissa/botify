class Town < ApplicationRecord

    def self.show_towns(params)
        @towns = []
        @order_by = nil
        if  params["page_size"] && params["page_number"] || params["filter"]
        @order_by = params["order_by"] if params["order_by"]
        @where_filters = params["filter"] if params["filter"]
        @towns = Town.where(@where_filters).page(params['page_number']).per(params['page_size']).order(@order_by)
        else 
        @towns = Town.all
        end
        return @towns
    end

end
