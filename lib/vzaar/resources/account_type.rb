module Vzaar
  module Resource
    class AccountType < Base
      root_node "//account"

      attribute :title
      attribute :id, type: :integer, field: :account_id
      attribute :monthly, type: :integer, node: "cost"
      attribute :currency, node: "cost"
      attribute :borderless, node: "rights", type: :boolean
      attribute :bandwidth, type: :integer
      attribute :search_enhancer, node: "rights", type: :boolean, field: :searchEnhancer

    end
  end
end
