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
    response = self.class.get(base_url("mentors/#{mentor_id}/student_availability"), headers: {'authorization' => @auth_token})
    @mentor_avail = JSON.parse(response.body)
  end

  def get_messages(pg = nil)
    has_page = pg.nil? ? '' : "?page=#{pg}"
    response = self.class.get(base_url("message_threads#{has_page}"), headers: {'authorization' => @auth_token})
    @messages = JSON.parse(response.body)
  end

  def create_message(sender_email, recipient_id, subject, message_body)
    self.class.post(base_url("messages"), headers: {'authorization' => @auth_token}, body: {'sender': sender_email, 'recipient_id': recipient_id, 'subject': subject, 'striped_text': message_body  } )

  end
  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment)
    self.class.post(base_url("checkpoint_submissions"), headers: {'authorization' => @auth_token}, body: { 'assignment_branch': assignment_branch, 'assignment_commit_link': assignment_commit_link, 'checkpoint_id': checkpoint_id, 'comment': comment, 'enrollment_id': enrollment_id } )

  end
  private

  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end


end
