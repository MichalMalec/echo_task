class MockController < ApplicationController
  def handle
    path = "/#{params[:path]}"
    method = request.method

    endpoint = Endpoint.find_by(path: path, verb: method)
    
    if endpoint
      response_headers = endpoint.headers || {}
      response_body = endpoint.body.present? ? JSON.parse(endpoint.body) : {}

      render json: response_body, status: endpoint.code, headers: response_headers
    else
      render json: { "errors": [ { "code": "not_found", "detail": "Requested page #{path} does not exist" } ]  }, status: :not_found
    end
  end
end
