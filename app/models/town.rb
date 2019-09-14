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

    def self.aggregate(params)
        query = "SELECT count(*) AS towns_number, MIN(population) AS min, MAX(population) AS max, AVG(population) AS average
                 FROM towns
                 WHERE #{params.keys[0]} = #{params.values[0]}"
        @towns = ActiveRecord::Base.connection.execute(query)
        return @towns
    end

end
