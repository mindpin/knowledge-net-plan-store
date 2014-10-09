module KnowledgeNetPlanStore
  class Plan
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, :type => String
    field :desc, :type => String

    has_many :topics, :dependent => :destroy

    validates :title, :presence => true

    def attrs(shallow: true)
      {
        :id         => self.id.to_s,
        :desc       => self.desc,
        :title      => self.title,
        :created_at => self.created_at,
        :updated_at => self.updated_at
      }.merge(shallow ?
              {:topic_ids => self.topic_ids.map(&:to_s)} :
              {:topics    => self.topics.map {|t| t.attrs(shallow: false)}})
       .merge(respond_to?(:net_id) ?
              {:net_id => self.net_id.to_s} :
              {})
    end
  end
end
