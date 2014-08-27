module KnowledgeNetPlanStore
  class Uploader < CarrierWave::Uploader::Base
    storage :file

    def default_url
      "/assets/defaults/#{base}.png"
    end

    def base
      model.class.name.split("::").last.underscore
    end
  end
end
