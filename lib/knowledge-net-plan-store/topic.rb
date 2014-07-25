module KnowledgeNetPlanStore
  class Topic
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, :type => String
    field :desc, :type => String

    has_many   :tutorials
    belongs_to :plan

    validates :title, :presence => true

    def attrs
      {
        :id        => self.id.to_s,
        :desc      => self.desc,
        :title     => self.title,
        :tutorials => self.tutorials.map(&:attrs)
      }
    end
  end
end
