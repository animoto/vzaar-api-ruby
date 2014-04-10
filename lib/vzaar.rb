$: << File.dirname(__FILE__)

module Vzaar
  module Helper
    def blank?(obj)
      obj.nil? or obj == ""
    end

    def symb_keys(hash)
      h = {}
      hash.each_pair do |k,v|
        h[k.to_sym] = v.is_a?(Hash) ? v.symb_keys : v
      end
      h
    end
  end
end

require 'pry'
require 'httpclient'
require 'nokogiri'
require 'oauth'
require 'vzaar/response/xml'
require 'vzaar/connection'
require 'vzaar/vzaar_error'
require 'vzaar/http'
require 'vzaar/video'


require 'vzaar/s3_uploader'
require 'vzaar/request/base'

# request
require 'vzaar/request/who_am_i'
require 'vzaar/request/account_type'
require 'vzaar/request/user_details'
require 'vzaar/request/video_details'
require 'vzaar/request/video_list'
require 'vzaar/request/delete_video'


# response
require 'vzaar/response/who_am_i'
require 'vzaar/response/account_type'
require 'vzaar/response/user_details'
require 'vzaar/response/video_details'
require 'vzaar/response/video_list'
require 'vzaar/response/signature'
require 'vzaar/response/process_video'

require 'vzaar/api'
require 'vzaar/request/edit_video'
require 'vzaar/request/process_video'
require 'vzaar/request/signature'
require 'vzaar/request/url'
require 'vzaar/response/handler'
require 'vzaar/base'
