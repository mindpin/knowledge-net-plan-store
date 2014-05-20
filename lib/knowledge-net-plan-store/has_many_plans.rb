module KnowledgeNetPlanStore
  module HasManyPlans
    def self.included(base)
      base.send :has_many,
                :plans,
                :class_name => Plan.to_s

      Plan.send :belongs_to,
                base.to_s.split("::").first.downcase,
                :class_name => base.to_s
    end
  end
end
