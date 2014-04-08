module Vzaar
  class WhoAmI < Response::XML

    attr_reader :login

    def initialize(xml)
      super(xml)
      @login = extract_text('//test/login')
    end

  end
end
