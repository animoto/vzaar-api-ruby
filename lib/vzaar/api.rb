module Vzaar
  class Api < Struct.new(:conn)

    def whoami(opts={})
      resource = Request::WhoAmI.new(conn, opts).execute
      resource.login
    end

    def account_type(account_type_id, opts={})
      _opts = opts.merge(:account_type_id => account_type_id)
      Request::AccountType.new(conn, _opts).execute
    end

    def user_details(login, opts={})
      Request::UserDetails.new(conn, opts.merge(:login => login)).execute
    end

    def video_details(video_id, opts={})
      Request::Video.new(conn, opts.merge(:video_id =>video_id)).execute
    end

    def video_list(login, opts={})
      Request::VideoList.new(conn, opts.merge(:login => login)).execute
    end

    def videos(opts={})
      video_list(conn.login, { :authenticated => true, :page => opts[:page] })
    end

    def delete_video(video_id, opts={})
      Request::DeleteVideo.new(conn, opts.merge(:video_id => video_id)).execute
    end

    def edit_video(video_id, opts={})
      Request::EditVideo.new(conn, opts.merge(:video_id => video_id)).execute
    end

    def signature(opts={})
      Request::Signature.new(conn, opts).execute
    end

    def process_video(opts={})
      Request::ProcessVideo.new(conn, opts).execute
    end

    def upload_video(opts={})
      uploader = Uploader.new(conn, signature, opts)
      uploader.upload do |u|
        process_video(u.processing_params)
      end
    end
  end
end
