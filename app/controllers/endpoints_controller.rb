class EndpointsController < ApplicationController
  before_action :endpoint_exists?, only: [:update, :destroy]

  def index
    @endpoints = Endpoint.all
    render json: { data: ActiveModelSerializers::SerializableResource.new(@endpoints, each_serializer: EndpointSerializer) }
  end

  def create
    @endpoint = Endpoint.new(endpoint_params)
    
    if @endpoint.save
      render json: { data: ActiveModelSerializers::SerializableResource.new(@endpoint, each_serializer: EndpointSerializer) }, status: :created
    else
      render json: {
        errors: @endpoint.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @endpoint.update(endpoint_params)
      render json: { data: ActiveModelSerializers::SerializableResource.new(@endpoints, each_serializer: EndpointSerializer) }
    else
      render json: {
        errors: @endpoint.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @endpoint.destroy
  end

  private

  def endpoint_exists?
    @endpoint = Endpoint.find_by(id: params[:id])
    unless @endpoint
      render json: {
        errors: [
          {
            code: "not_found",
            detail: "Requested Endpoint with ID #{params[:id]} does not exist"
          }
        ]
      }, status: :not_found
    end
  end

  def endpoint_params
    params.require(:endpoint).permit(:verb, :path, :code, :headers, :body)
  end
end
