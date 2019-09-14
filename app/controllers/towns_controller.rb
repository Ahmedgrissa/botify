class TownsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: Town.show_towns(town_params)
    end
  
    private
  
      def town_params
        params.permit(:page_size, :page_number)
      end
end
  