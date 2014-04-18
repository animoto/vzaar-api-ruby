module Vzaar
  module Resource
    class Base
      attr_reader :response_body, :attributes, :api_version

      class << self
        def attributes(*attrs)
          klass = self
          node = attrs.shift.to_s

          define_method(:initialize) do |*args|
            response_body = args.first
            doc = Nokogiri::XML(response_body)
            self.instance_variable_set(:@response_body, response_body)

            attributes = attrs.map do |e|
              if e.is_a?(Hash)
                field_name = e[:field].to_s
                data_type = e[:type]
                method_name = e[:as] ? e[:as].to_s : field_name
                _node = e[:node] ? (node + "/" + e[:node].to_s) : node
              else
                field_name = e.to_s
                method_name = field_name
                data_type = :string
                _node = node
              end

              value = extract_value(doc, _node, field_name)
              _method_body = klass.method_body(method_name, value, data_type)

              define_singleton_method(method_name, _method_body)
            end

            self.instance_variable_set(:"@attributes", attributes)

            api_version = extract_value(doc, node, "/version")
            self.instance_variable_set(:"@api_version", api_version.to_f)
          end
        end

        def method_body(name, value, type=nil)
          val = case type
                when :integer then value.to_i
                when :boolean
                  value =~ /^true$/i ? true : false
                when :fixnum
                  value.to_f
                when :datetime
                  Time.parse(value).utc
                else
                  value
                end

          return lambda do
            self.instance_variable_get(:"@#{name}") ||
            self.instance_variable_set(:"@#{name}", val)
          end
        end
      end

      protected

      def extract_value(doc, node, field_name)
        extract_text(doc, build_xpath(node, field_name))
      end

      def build_xpath(node, field_name)
        "//#{node}/" + field_name
      end

      def extract_text(doc, xpath)
        return '' if response_body.to_s == ''
        doc.at_xpath(xpath) ? doc.at_xpath(xpath).text : ''
      end

    end
  end
end
