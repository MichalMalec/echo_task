class MockController < ApplicationController
  def handle
    endpoint = find_endpoint

    if endpoint
      render_endpoint_response(endpoint)
    else
      render_not_found
    end
  end

  private

  def find_endpoint
    path = "/#{params[:path]}"
    method = request.method
    Endpoint.find_by(path: path, verb: method)
  end

  def render_endpoint_response(endpoint)
    response_headers = endpoint.headers || {}
    response_body = parse_response_body(endpoint.body)

    render json: response_body, status: endpoint.code, headers: response_headers
  end

  def parse_response_body(body)
    body.present? ? JSON.parse(body) : {}
  end

  def render_not_found
    render json: { errors: [{ code: "not_found", detail: "Requested page #{params[:path]} does not exist" }] }, status: :not_found
  end
end
