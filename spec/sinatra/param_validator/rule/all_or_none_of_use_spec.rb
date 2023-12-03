# frozen_string_literal: true

require "sinatra/test_helpers"

describe Sinatra::ParamValidator::Rule::AllOrNoneOf do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        rule :all_or_none_of, :a, :b
      end

      post "/", validate: :identifier do
        "OK".to_json
      end
    end
  end

  it "passes with both params" do
    post "/", { a: :a, b: :b }
    expect(last_response).to be_ok
  end

  it "fails with one param" do
    expect { post "/", { a: :a } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end

  it "passes with no params" do
    post "/"
    expect(last_response).to be_ok
  end
end
