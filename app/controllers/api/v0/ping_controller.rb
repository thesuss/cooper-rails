class Api::V0::PingController < ApiController
  def index
    render json: {message: 'Pong'}
  end
end
