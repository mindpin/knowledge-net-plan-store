module KnowledgeNetPlanStore
  module Serializer
    def json
      JSON.generate self.attrs
    end
  end
end
