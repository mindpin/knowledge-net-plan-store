module KnowledgeNetPlanStore
  module HasManyPlans
    def self.included(base)
      base.send :has_many,
                :plans,
                :class_name => Plan.name,
                :dependent => :destroy

      Plan.send :belongs_to,
                base.class_name.element,
                :class_name => base.name
    end
  end
end
