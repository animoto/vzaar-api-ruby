module Vzaar
  module Uploaders
    class Link < Struct.new(:conn, :signature_hash, :opts)
      LIMIT = 25

      def upload
        success = false
        Request::LinkUpload.new(conn, upload_params).execute

        LIMIT.times do
          puts "checking upload status..."
          sleep 4
          res = check_file_upload

          case res[:status]
          when "finished"
            success = true
            puts "sending video to processing queue..."
            break
          when "failure"
            success = false
            puts "file upload failed :-("
            break
          else
            puts "file upload in progress... #{res[:progress]}"
          end

        end
        success
      end

      def check_file_uplaod
        Request::UploadStatus.new(conn, upload_status_params).execute
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
