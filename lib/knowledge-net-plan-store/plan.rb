module KnowledgeNetPlanStore
  class Plan
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :desc, :type => String

    has_many :topics

    validates :name, :presence => true

    def attrs
      {
        :id     => self.id.to_s,
        :desc   => self.desc,
        :name   => self.name,
        :topics => self.topics.map(&:attrs)
      }
    end
  end
end
