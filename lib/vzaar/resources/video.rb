module Vzaar
  module Resource
    class Video < Base
      attributes( :oembed, :type, :title, :html, :description, :provider_name,
                  :provider_url, :thumbnail_url, :framegrab_url,

                  { field: :author_name, as: :user_name },
                  { field: :author_url, as: :user_url },
                  { field: :video_url, as: :url },
                  { field: :author_account, as: :user_account },
                  { field: :width, type: :integer },
                  { field: :height, type: :integer },
                  { field: :thumbnail_width, type: :integer },
                  { field: :thumbnail_height, type: :integer },
                  { field: :framegrab_width, type: :integer },
                  { field: :framegrab_height, type: :integer },
                  { field: :duration, type: :integer },
                  { field: :play_count, type: :integer },
                  { field: :video_status_id, type: :integer, as: :status_id },
                  { field: :video_status_description, as: :status_description })
    end
  end
end
