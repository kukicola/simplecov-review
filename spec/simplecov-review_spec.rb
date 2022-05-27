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
    let(:output_path) { File.join(SimpleCov.coverage_path, 'review.txt') }
    let(:expected_result) do
      [
        "spec/example/example.rb:5:1: Missing coverage for lines 5-7\n",
        "spec/example/example.rb:13:1: Missing coverage for line 13\n"
      ].join
    end

    it 'returns lines that are missing coverage' do
      subject
      expect(File.read(output_path)).to eq(expected_result)
    end
  end
end
