module KnowledgeNetPlanStore
  class Plan
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, :type => String
    field :desc, :type => String

    has_many :topics

    validates :title, :presence => true

    def attrs
      {
        :id     => self.id.to_s,
        :desc   => self.desc,
        :title  => self.title,
        :topics => self.topics.map(&:attrs)
      }
    end
  end
end
