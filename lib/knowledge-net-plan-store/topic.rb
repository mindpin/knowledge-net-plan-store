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

    def attrs(shallow: true)
      {
        :id         => self.id.to_s,
        :desc       => self.desc,
        :title      => self.title,
        :plan_id    => self.plan_id.to_s,
        :created_at => self.created_at.to_s,
        :updated_at => self.updated_at.to_s
      }.merge(shallow ?
              {:tutorial_ids => self.tutorial_ids.map(&:to_s)} :
              {:tutorials    => self.tutorials.map(&:attrs)})
    end
  end
end
