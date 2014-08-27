module KnowledgeNetPlanStore
  class Uploader < CarrierWave::Uploader::Base
    storage :file
  end
end
