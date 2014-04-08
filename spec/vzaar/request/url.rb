require 'spec_helper'
require './lib/vzaar/request/url'

describe Vzaar::Request::Url do
  let(:params) do
    { page: 1 }
  end

  let(:url) { "/api/endpoint" }

  subject { described_class.new(url, params) }

  describe "#build" do
    specify do
      subject.build()
    end

  end
end
