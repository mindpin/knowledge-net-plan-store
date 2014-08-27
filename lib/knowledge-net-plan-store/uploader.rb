module KnowledgeNetPlanStore
  class Uploader < CarrierWave::Uploader::Base
    storage :file

    def store_dir
      "public/images/#{base}-#{model.id.to_s}"
    end

    def default_url
      "/assets/defaults/#{base}.png"
    end

    def base
      model.class.name.split("::").last.underscore
    end
  end
end
