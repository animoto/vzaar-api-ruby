module Vzaar
  module Request
    class WhoAmI < Base
      endpoint '/api/test/whoami'
      authenticated true
    end
  end
end
