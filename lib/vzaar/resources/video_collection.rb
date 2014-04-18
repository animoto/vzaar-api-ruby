module Vzaar
  module Resource
    class VideoCollection < Array

      def initialize(xml_body)
        doc = Nokogiri::XML(xml_body)
        doc.xpath("//videos/video").each do |xml|
          push(Video.new(xml.to_s, "//video"))
        end
      end
    end
  end
end
