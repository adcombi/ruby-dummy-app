require 'test_helper'

describe "v1/routes/base" do
  describe "when requesting /info.json" do
    it "must respond with the author and a version" do
      get '/info.json'
      assert last_response.status == 200
      assert_includes last_response.content_type, 'application/json'
      assert json_parse(last_response.body)[:version] == "1.0.0"
    end
  end

end