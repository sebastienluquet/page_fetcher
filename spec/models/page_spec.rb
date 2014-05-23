require 'spec_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

describe Page do
  describe "with invalid params" do
    it "generate some error on page_id" do
      VCR.use_cassette('empty_page') do
        Page.create :page_id => ""
      end
    end
  end
  describe "without cover" do
    it "generate an image" do
      VCR.use_cassette('no_cover_page') do
        Page.create :page_id => "275210472538154"
      end
    end
  end
end
