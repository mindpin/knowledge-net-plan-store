module KnowledgeNetPlanStore
  class LearnRecord
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps::Created

    belongs_to :tutorial
    
    def attrs
      {
        :tutorial_id  => self.tutorial_id.to_s,
        :user_id => self.user_id.to_s,
        :created_at => self.created_at.to_s
      }
    end
  end
end
