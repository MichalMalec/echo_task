class EndpointsController < ApplicationController
  before_action :set_endpoint, only: [:update, :destroy]
  before_action :ensure_endpoint_exists, only: [:update, :destroy]

  def index
    endpoints = Endpoint.all
    render json: { data: serialize_collection(endpoints) }
  end

  def create
    endpoint = Endpoint.new(endpoint_params)

    if endpoint.save
      render json: { data: serialize_resource(endpoint) }, status: :created
    else
      render_error(endpoint.errors.full_messages, :unprocessable_entity)
    end
  end

  def update
    if @endpoint.update(endpoint_params)
      render json: { data: serialize_resource(@endpoint) }
    else
      render_error(@endpoint.errors.full_messages, :unprocessable_entity)
    end
  end

  def destroy
    @endpoint.destroy
    head :no_content
  end

  private

  def set_endpoint
    @endpoint = Endpoint.find_by(id: params[:id])
  end

  def ensure_endpoint_exists
    unless @endpoint
      render_error("Requested Endpoint with ID #{params[:id]} does not exist", :not_found)
    end
  end

  def endpoint_params
    data = params.require(:data)
    attributes = data.require(:attributes)
    {
      verb: attributes[:verb],
      path: attributes[:path],
      code: attributes.dig(:response, :code),
      headers: attributes.dig(:response, :headers),
      body: attributes.dig(:response, :body)
    }
  end

  def serialize_resource(resource)
    ActiveModelSerializers::SerializableResource.new(resource, serializer: EndpointSerializer)
  end

  def serialize_collection(collection)
    ActiveModelSerializers::SerializableResource.new(collection, each_serializer: EndpointSerializer)
  end

  def render_error(messages, status)
    render json: { errors: Array(messages).map { |msg| { detail: msg } } }, status: status
  end
end
