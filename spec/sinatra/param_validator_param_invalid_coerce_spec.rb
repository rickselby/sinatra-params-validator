# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator :identifier do
        param :max, Integer, required: true
      end

      post '/', validate: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'raises an error for an invalid parameter type' do
    expect { post '/', { max: 'foo' } }.to raise_error 'Validation Failed'
  end
end