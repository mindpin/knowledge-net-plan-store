module KnowledgeNetPlanStore
  class Tutorial
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps
    include ActsAsDag

    field :title,     :type => String
    field :desc,      :type => String
    field :published, :type => Boolean

    scope :published, proc {where(:published => true)}

    mount_uploader :image, Uploader

    belongs_to :topic

    validates :title, :presence => true

    def attrs
      {
        :id         => self.id.to_s,
        :desc       => self.desc,
        :title      => self.title,
        :topic_id   => self.topic_id.to_s,
        :image      => self.image.url,
        :created_at => self.created_at,
        :updated_at => self.updated_at
      }
    end
  end
end
