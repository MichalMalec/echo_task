class MockController < ApplicationController
    def handle
        path = "/#{params[:path]}"
        method = request.method
    
        endpoint = Endpoint.find_by(path: path, method: method)
    
        if endpoint
          render json: JSON.parse(endpoint.response), status: :ok
        else
          render json: { error: 'Not found' }, status: :not_found
        end
      end
end
