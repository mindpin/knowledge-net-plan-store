module KnowledgeNetPlanStore
  module Serializer
    def json
      JSON.generate self.attrs(shallow: false)
    end
  end
end
