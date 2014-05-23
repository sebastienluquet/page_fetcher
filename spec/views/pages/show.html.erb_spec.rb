require 'spec_helper'
VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
describe "pages/show" do
  before(:each) do
    @page = assign(:page, stub_model(Page, :page_id => 275210472538154))
  end

  it "renders attributes in <p>" do
    VCR.use_cassette('page_feed') do
      render
    end
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

  describe "with deleted page" do
    before(:each) do
      @page = assign(:page, stub_model(Page, :page_id => 275210472538153))
    end

    it "renders attributes in <p>" do
      VCR.use_cassette('missing_page_feed') do
        render
      end
      # Run the generator again with the --webrat flag if you want to use webrat matchers
    end
  end
end
