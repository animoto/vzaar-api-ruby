module Vzaar
  module Uploaders
    class Link < Struct.new(:conn, :signature_hash, :opts)
      def upload
        success = false
        Request::LinkUpload.new(conn, upload_params).execute

        20.times do
          puts "checking upload status..."
          sleep 4
          if file_ready?
            success = true
            puts "sending video to processing queue..."
            break
          end
        end
        success
      end

      def file_ready?
        res = Request::UploadStatus.new(conn, upload_status_params).execute
        res[:status] == "finished"
      end

      def upload_status_params
        @upload_status_params ||= { guid: guid, format: :json, l: opts[:l] }
      end

      private

      def guid
        signature_hash[:guid]
      end

      def upload_params
        { guid: guid,
          key: signature_hash[:key],
          format: :json,
          url: opts[:url],
          l: opts[:l]
        }
      end
    end
  end
end
