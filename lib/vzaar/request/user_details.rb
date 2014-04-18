module Vzaar
  module Request
    class UserDetails < Base
      endpoint { |o| "/api/users/#{o.login}" }
      resource "User"

      def login
        options[:login]
      end
    end
  end
end
