module KnowledgeNetPlanStore
  class Tutorial
    include Serializer
    include Mongoid::Document
    include Mongoid::Timestamps
    include ActsAsDag

    field :title, :type => String
    field :desc,  :type => String

    mount_uploader :image, Uploader

    has_many :learn_records
    belongs_to :topic

    validates :title, :presence => true

    def learned_by!(user)
      self.learn_records.create(:user => user)
    end

    def with_learner(user)
      @learner = user
      self
    end

    def learned_by?(user)
      self.learn_records.where(:user_id => user.id).size > 0
    end

    def learn!
      self.learned_by!(@learner)
    end

    def learned?
      self.learned_by?(@learner)
    end

    def attrs
      hash = {
        :id         => self.id.to_s,
        :desc       => self.desc,
        :title      => self.title,
        :topic_id   => self.topic_id.to_s,
        :image      => self.image.url,
        :created_at => self.created_at.to_s,
        :updated_at => self.updated_at.to_s
      }

      @learner ? hash.merge(:is_learned => learned?) : hash
    end
  end
end
