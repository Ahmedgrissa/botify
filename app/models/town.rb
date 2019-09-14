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

    def self.convert_json_to_query(conversion_params)
        fields_string = conversion_params['fields'].join(',')
        query = "SELECT #{fields_string} FROM towns "
        if conversion_params["filters"].present?
            filter = get_filter(conversion_params["filters"])
            if filter 
                query += "WHERE #{filter}"
            end
        end
        return query
    end

    def self.get_filter(filters)
        field = filters["field"]
        operation = get_operation(filters)
        # si predicate n'est pas dans la liste on ignore le filtre et on affiche la reqûete
        if operation.present?
            filters = "#{field} #{operation}"
            return filters
        end
    end

    def self.get_operation(params)
        operation = ''
        case params["predicate"]
          when nil || "equal"
            operation = "= #{params['value']}"
          when  "gt" 
            operation = "> #{params['value']}"
          when  "lt" 
            operation = "< #{params['value']}"
          when  "contains" 
            operation = "LIKE '%#{params['value']}%'"
        end
        return operation
    end

end
