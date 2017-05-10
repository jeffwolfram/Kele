require "httparty"
require "json"
require './lib/roadmap'
class Kele
  include HTTParty
  include Roadmap


  headers = {
    :content_type => 'application/json'
  }
  def initialize(email, password)
    response = self.class.post(base_url('sessions'), body: {'email': email, 'password': password})
    @auth_token = response['auth_token']
  end

  def get_me
    response = self.class.get(base_url('users/me'), headers: {'authorization' => @auth_token})
    @user_info = JSON.parse(response.body)

  end

  def get_mentor_availability(mentor_id)
    @mentor_id = mentor_id
    response = self.class.get(base_url(mentor_id_number), headers: {'authorization' => @auth_token})
    @mentor_avail = JSON.parse(response.body)
  end
    private

    def base_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end
    def mentor_id_number
      "mentors/#{@mentor_id}/student_availability"
    end

end
