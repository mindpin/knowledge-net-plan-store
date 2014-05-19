module KnowledgeNetPlanStore
  class Topic
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :desc, :type => String

    has_many   :tutorials
    belongs_to :plan

    validates :name, :presence => true

    def attrs
      {
        :id        => self.id.to_s,
        :desc      => self.desc,
        :name      => self.name,
        :tutorials => self.tutorials.map(&:attrs)
      }
    end
  end
end
