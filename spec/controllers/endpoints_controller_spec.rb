require 'rails_helper'

RSpec.describe EndpointsController, type: :controller do
  let!(:endpoint) { create(:endpoint) }

  describe 'GET #index' do
    it 'returns a list of endpoints' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('data')
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        data: {
          type: 'endpoints',
          attributes: {
            verb: 'GET',
            path: '/greeting',
            response: {
              code: 200,
              headers: {},
              body: '{"message": "Hello, world"}'
            }
          }
        }
      }
    end

    let(:invalid_attributes) do
      {
        data: {
          type: 'endpoints',
          attributes: {
            verb: 'INVALID',
            path: '/greeting',
            response: {
              code: 200
            }
          }
        }
      }
    end

    context 'with valid attributes' do
      it 'creates a new endpoint' do
        expect {
          post :create, params: valid_attributes
        }.to change(Endpoint, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to include('data')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new endpoint' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(Endpoint, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_attributes) do
      {
        data: {
          type: 'endpoints',
          attributes: {
            verb: 'POST',
            path: '/updated_path',
            response: {
              code: 200,
              headers: {},
              body: '{"message": "Updated!"}'
            }
          }
        }
      }
    end

    let(:invalid_attributes) do
      {
        data: {
          type: 'endpoints',
          attributes: {
            verb: 'INVALID'
          }
        }
      }
    end

    context 'with valid attributes' do
      it 'updates the requested endpoint' do
        patch :update, params: { id: endpoint.id, **valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('data')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the endpoint' do
        patch :update, params: { id: endpoint.id, **invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end

    context 'when the endpoint does not exist' do
      it 'returns a not found error' do
        patch :update, params: { id: 'nonexistent_id', **valid_attributes }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested endpoint' do
      expect {
        delete :destroy, params: { id: endpoint.id }
      }.to change(Endpoint, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    context 'when the endpoint does not exist' do
      it 'returns a not found error' do
        delete :destroy, params: { id: 'nonexistent_id' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('errors')
      end
    end
  end
end
