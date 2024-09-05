class EndpointsController < ApplicationController
  before_action :set_endpoint, only: [:update, :destroy]

  def index
    @endpoints = Endpoint.all
    render json: @endpoints
  end

  def create
    @endpoint = Endpoint.new(endpoint_params)
    
    if @endpoint.save
      render json: @endpoint, status: :created
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  def update
    if @endpoint.update(endpoint_params)
      render json: @endpoint
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @endpoint.destroy
  end

  private

  def set_endpoint
    @endpoint = Endpoint.find_by(id: params[:id])
    render json: { error: 'Endpoint not found' }, status: :not_found unless @endpoint
  end

  def endpoint_params
    params.require(:endpoint).permit(:verb, :path, :code, :headers, :body)
  end
end
