module Vzaar
  class Api

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def whoami(opts={})
      url = '/api/test/whoami'
      connection.using_authorised_connection(url) do |xml|
        return WhoAmI.new(xml).login
      end
    end

    def account_type(account_type_id, opts={})
      url = "/api/accounts/#{account_type_id}.xml"
      connection.using_public_connection(url) do |xml|
        return AccountType.new(xml)
      end
    end

    def user_details(login, opts={})
      url = "/api/users/#{login}.xml"
      connection.using_connection(url, opts) do |xml|
        return User.new(xml)
      end
    end

    def video_details(video_id, opts={})
      url = "/api/videos/#{video_id}.xml"
      connection.using_connection(url, opts) do |xml|
        return VideoDetails.new(video_id, xml)
      end
    end

    def video_list(login, opts={})
      url = "/api/#{login}/videos.xml?page=#{opts[:page] || 1}"
      connection.using_connection(url, opts) do |xml|
        return VideoCollection.new(xml)
      end
    end

    def videos(opts={})
      video_list(connection.login, { authenticated: true, page: opts[:page] })
    end

    def delete_video(video_id, opts={})
      url = "/api/videos/#{video_id}.xml"
      connection.using_authorised_connection(url, http_verb: Http::DELETE)
    end

    def edit_video(video_id, options = {})
      url = "/api/videos/#{video_id}.xml"
      request = Request::EditVideo.new(options)
      params = { http_verb: Http::PUT, data: request.xml }

      connection.using_authorised_connection(url, params)
    end

    def signature(options = {})
      request = Request::Signature.new('/api/videos/signature', options)
      connection.using_authorised_connection(request.url) do |xml|
        return Signature.new xml
      end
    end

    def upload_video(path, options = {})
      sig = signature
      if upload_to_s3(path, sig)
        process_video :guid => sig.guid, :title => options[:title],
          :description => options[:description], :profile => options[:profile],
          :transcoding => options[:transcoding]
      end
    end

    def process_video(options = {})
      url = '/api/videos'
      request = Request::ProcessVideo.new(options)
      params = { http_verb: Http::POST, data: request.xml }

      connection.using_authorised_connection(url, params) do |xml|
        return ProcessVideo.new(xml).video_id
      end
    end

    private

    def upload_to_s3(file_path, signature)
      uploader = S3Uploader.new(file_path, signature)
      uploader.upload
    rescue Exception => e
      VzaarError.generate :unknown, e.message
    end
  end
end
