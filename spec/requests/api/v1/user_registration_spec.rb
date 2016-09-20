require 'rails_helper'

describe 'User Registrtion' do
  let(:headers) { {HTTP_ACCEPT: 'application/json'} }

  describe 'POST /api/v1/auth/' do
    describe 'register a user' do
      it 'with valid sign up returns user & token' do
        post '/api/v1/auth', {email: 'thomas@craftacademy.se',
                              password: 'password',
                              password_confirmation: 'password'}, headers
        expect(response_json['status']).to eq('success')
        expect(response.status).to eq 200
      end

      it 'with an invalid password confirmation returns error message' do
        post '/api/v1/auth', {email: 'thomas@craftacademy.se',
                              password: 'password',
                              password_confirmation: 'wrong_password'}, headers
        expect(response_json['errors']['password_confirmation']).to eq(['doesn\'t match Password'])
        expect(response.status).to eq 403
      end

      it 'with an invalid email returns error message' do
        post '/api/v1/auth', {email: 'thomas@craft',
                              password: 'password',
                              password_confirmation: 'password'}, headers
        expect(response_json['errors']['email']).to eq(['is not an email'])
        expect(response.status).to eq 403
      end

      it 'with an already registered email returns error message' do
        User.create(email: 'thomas@craftacademy.se',
                    password: 'password',
                    password_confirmation: 'password')
        post '/api/v1/auth', {email: 'thomas@craftacademy.se',
                               password: 'password',
                               password_confirmation: 'password'}, headers
        expect(response_json['errors']['email']).to eq(['already in use'])
        expect(response.status).to eq 403
      end
    end
  end
end
