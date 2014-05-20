module KnowledgeNetPlanStore
  module HasManyTutorials
    def self.included(base)
      base.send :has_many,
                :tutorials,
                :class_name => Tutorial.to_s

      Tutorial.send :belongs_to,
                    base.to_s.split("::").first.downcase,
                    :class_name => base.to_s
    end
  end
end
