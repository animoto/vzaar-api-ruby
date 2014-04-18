module Vzaar
  module Resource
    class User < Base
      attributes( :user,
                  :created_at,

                  { field: :created_at, type: :datetime },
                  { field: :author_account, as: :account_type_id },
                  { field: :max_file_size, type: :integer },
                  { field: :author_account_title, as: :account_type_name },
                  { field: :author_name, as: :name },
                  { field: :author_url, as: :url },
                  { field: :version, type: :fixnum },
                  { field: :author_id, as: :id, type: :integer },
                  { field: :video_count, as: :video_count, type: :integer })
    end
  end
end
