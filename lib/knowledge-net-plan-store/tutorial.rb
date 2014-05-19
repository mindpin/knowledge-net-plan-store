module KnowledgeNetPlanStore
  class Tutorial
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :desc, :type => String

    belongs_to :topic

    validates :name, :presence => true

    def attrs
      {
        :id   => self.id.to_s,
        :desc => self.desc,
        :name => self.name
      }
    end
  end
end
