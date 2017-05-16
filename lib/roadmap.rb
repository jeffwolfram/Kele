module Roadmap

def get_roadmap(roadmap_id)

  response = self.class.get(base_url("/roadmaps/#{roadmap_id}"), headers: {'authorization' => @auth_token})
  @roadmap = JSON.parse(response.body)
end
def get_checkpoint_id(checkpoint_id)
  response = self.class.get(base_url("/roadmaps/#{checkpoint_id}"), headers: {'authorization' => @auth_token})
  @checkpoint = JSON.parse(response.body)
end
end
