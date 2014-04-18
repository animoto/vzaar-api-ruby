module Vzaar
  module Resource
    class Video < Base
      root_node "//oembed"

      attribute :type
      attribute :title
      attribute :html
      attribute :description
      attribute :provider_name
      attribute :provider_url
      attribute :thumbnail_url
      attribute :framegrab_url
      attribute :user_name, field: :author_name
      attribute :user_url, field: :author_url
      attribute :url, field: :video_url
      attribute :user_account, field: :author_account
      attribute :width, type: Integer
      attribute :height, type: Integer
      attribute :thumbnail_width, type: Integer
      attribute :thumbnail_height, type: Integer
      attribute :framegrab_height, type: Integer
      attribute :framegrab_width, type: Integer
      attribute :duration, type: Integer
      attribute :play_count, type: Integer
      attribute :status_id, field: :video_status_id, type: Integer
      attribute :status_description, field: :video_status_description
    end
  end
end
