class Town < ApplicationRecord

    def self.show_towns(params)
        @towns = []
        if  params["page_size"] && params["page_number"] 
        @towns = Town.page(params['page_number']).per(params['page_size'])
        else 
        @towns = Town.all
        end
        return @towns
    end

end
