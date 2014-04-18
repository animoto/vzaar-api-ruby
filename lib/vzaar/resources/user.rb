module Vzaar
  module Resource
    class User < Base
      root_node "//user"

      attribute :created_at, type: Time
      attribute :max_file_size, type: Integer
      attribute :account_type_id, field: :author_account, type: Integer
      attribute :account_type_name, field: :author_account_title
      attribute :name, field: :author_name
      attribute :url, field: :author_url
      attribute :id, field: :author_id, type: Integer
      attribute :video_count, type: Integer
      attribute :play_count, type: Integer
    end
  end
end
