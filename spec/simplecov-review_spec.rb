# frozen_string_literal: true

require 'simplecov-review'
require 'simplecov'

RSpec.describe SimpleCov::Formatter::ReviewFormatter do
  before do
    SimpleCov.start
    load 'example/example.rb'
  end

  describe '#format' do
    subject { described_class.new.format(simplecov_result) }

    let(:simplecov_result) { SimpleCov.result }

    let(:expected_result) do
      [
        "spec/example/example.rb:5:1: Missing coverage for lines 5-6\n",
        "spec/example/example.rb:12:1: Missing coverage for line 12\n"
      ].join
    end

    it 'returns lines that are missing coverage' do
      expect(subject).to eq(expected_result)
    end
  end
end
