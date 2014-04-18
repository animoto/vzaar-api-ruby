module Vzaar
  module Resource
    class Base
      attr_reader :response_body, :api_version, :doc

      class << self
        def root_node(node)
          define_method(:initialize) do |*args|
            xml_body = args[0]
            _node = args[1] || node

            instance_variable_set(:@root_node, _node)
            instance_variable_set(:@doc, Nokogiri::XML(xml_body))
            set_api_version!(_node)
          end
        end

        def attribute(name, opts={})
          field_name = (opts[:field] || name).to_s
          data_type = opts[:type] || :string
          node = opts[:node]

          define_method(name) do
            val = instance_variable_get(:"@#{name.to_s}")
            unless val
              root_node = instance_variable_get(:@root_node)
              _node = node ? (root_node + "/" + node.to_s) : root_node

              value = extract_value(_node, field_name)
              return set_value!(name, value, data_type)
            end
            val
          end
        end
      end

      protected

      def set_value!(name, value, type=nil)
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

        instance_variable_set(:"@#{name}", val)
        val
      end

      def attributes
        @attributes ||= []
      end

      def set_api_version!(root_node)
        @api_version ||= doc.at_xpath(root_node + "/version").text.to_f
      end

      def extract_value(node, field_name)
        extract_text(build_xpath(node, field_name))
      end

      def build_xpath(node, field_name)
        node + "/" + field_name
      end

      def extract_text(xpath)
        doc.at_xpath(xpath) ? doc.at_xpath(xpath).text : ''
      end

    end
  end
end
