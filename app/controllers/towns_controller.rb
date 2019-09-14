class TownsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: Town.show_towns(town_params)
    end

    def aggregate
      if aggregation_params
        render json: Town.aggregate(aggregation_params)
      else
        render json: {message: "sorry bro"}
      end
    end

    def convert
      render json: { "query": Town.convert_json_to_query(conversion_params) }
    end
  
    private
  
      def town_params
        params.permit(:page_size, :page_number, :order_by, :filter)
      end

      def aggregation_params
        params.permit(:dept_code, :region_code)
      end

      def conversion_params
        params
      end
end
  