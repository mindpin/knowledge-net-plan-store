module KnowledgeNetPlanStore
  class Tutorial
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, :type => String
    field :desc, :type => String

    belongs_to :topic

    validates :title, :presence => true

    def attrs
      {
        :id   => self.id.to_s,
        :desc => self.desc,
        :title => self.title
      }
    end
  end
end
