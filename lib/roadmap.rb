module Roadmap

def get_roadmap(roadmap_id)
  @roadmap_id = roadmap_id
  response = self.class.get(base_url(roadmap_id_number), headers: {'authorization' => @auth_token})
  @roadmap = JSON.parse(response.body)
end
def get_checkpoint_id(checkpoint_id)
  response = self.class.get(base_url('/roadmaps/#{checkpoint_id}'), headers: {'authorization' => @auth_token})
  @checkpoint = JSON.parse(response.body)
end

private
def roadmap_id_number
  "/roadmaps/#{@roadmap_id}"

end

end
