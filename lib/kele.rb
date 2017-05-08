require "httparty"
class Kele


  def initialize(user, password)

      base_url'https://www.bloc.io/api/v1'
      @session = self.class.post("https://www.bloc.io/api/v1/sessions", {user:user, password: password})

  end
end
