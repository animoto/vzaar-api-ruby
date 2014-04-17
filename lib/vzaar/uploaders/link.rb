module Vzaar
  module Uploaders
    class Link < Struct.new(:conn, :signature_hash, :opts)

      def upload
        success = false
        progress = 0
        @timeout = nil

        Request::LinkUpload.new(conn, upload_params).execute

        while 1
          res = get_upload_status
          fsize = res[:filesize].to_i

          set_timeout!(fsize) if fsize > 0

          case res[:status]
          when "finished"
            success = true
            print_msg "upload completed"
            print_msg "sending video to processing queue..."
            break
          when "failure"
            success = false
            print_msg "file upload failed :-("
            break
          else
            if progress < 100
              progress = res[:progress].to_i
              print_msg "file upload in progress... #{progress}%"
            end
          end

          sleep @timeout || 10

        end
        success
      end

      private

      def print_msg(msg)
        puts(msg) if opts[:verbose]
      end

      def set_timeout!(fsize)
        @timeout ||= case
                     when fsize < 10000000 then 10
                     when fsize < 100000000 then 30
                     when fsize < 1000000000 then 60
                     else 120; end
      end

      def get_upload_status
        Request::UploadStatus.new(conn, upload_status_params).execute
      end

      def upload_status_params
        @upload_status_params ||= { guid: guid, format: :json, l: opts[:l] }
      end

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
