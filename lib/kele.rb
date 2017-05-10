require "httparty"
require "json"
class Kele
  include HTTParty


  headers = {
    :content_type => 'application/json'
  }
  def initialize(email, password)
      response = self.class.post(base_url('sessions'), body: {'email': email, 'password': password})
      @auth_token = response['auth_token']
      raise "Wrong Email and/or Password" if response.code != 200

  end
  def get_me
    response = self.class.get(base_url('users/me'), headers: {'authorization' => @auth_token})
    @user_info = JSON.parse(response.body)
    
  end

  private

  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
