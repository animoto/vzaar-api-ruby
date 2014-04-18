module Vzaar
  module Resource
    class AccountType < Base
      attributes( :account, :title,

                  { field: :bandwidth, type: :integer },
                  { field: :account_id, as: :id, type: :integer },
                  { field: :monthly, node: "cost", type: :integer },
                  { field: :currency, node: "cost" },
                  { field: :borderless, node: "rights", type: :boolean },
                  { field: :searchEnhancer,
                    node: "rights",
                    as: :search_enhancer,
                    type: :boolean
                  })
    end
  end
end
