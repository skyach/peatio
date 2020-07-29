# encoding: UTF-8
# frozen_string_literal: true

describe API::V2::Admin::Abilities, type: :request do
  let(:admin) { create(:member, :admin, :level_3, email: 'example@gmail.com', uid: 'ID73BF61C8H0') }
  let(:token) { jwt_for(admin) }

  describe 'GET /api/v2/admin/abilities' do
    it 'get all roles and permissions' do
      api_get '/api/v2/admin/abilities', token: token
      result = JSON.parse(response.body)

      expect(response).to be_successful
      expect(result['roles'].count).to eq 7
      expect(result['roles']).to eq ['admin', 'manager', 'accountant', 'superadmin', 'technical', 'compliance', 'support']
      expect(result['permissions'].count).to eq 7
      expect(result['permissions']['superadmin'].keys).to eq ['manage', 'read', 'update']
      expect(result['permissions']['superadmin']['read']).to eq ['Trade', 'Order']
      expect(result['permissions']['superadmin']['update']).to eq ['Order']
    end
  end
end
