# frozen_string_literal: true

require_relative 'simplecov-review/version'

module SimpleCov
  module Formatter
    FILENAME = 'review.txt'
    #
    # Simple formatter to report missing coverage for reporting tools
    #
    class ReviewFormatter
      def format(result)
        File.open(export_path, 'w') do |output_file|
          result.files.each do |file|
            find_missing_groups(file).each do |lines|
              output_file << error_for(file, lines)
            end
          end
        end
      end

      private

      def error_for(file, lines)
        filename = file.filename.gsub("#{SimpleCov.root}/", '')
        message = if lines.length > 1
                    "Missing coverage for lines #{lines.first}-#{lines.last}"
                  else
                    "Missing coverage for line #{lines.first}"
                  end
        "#{filename}:#{lines.first}:1: #{message}\n"
      end

      def find_missing_groups(file)
        lines_missing = file.lines.each_index.select { |index| file.lines[index].coverage&.zero? }.map { |l| l + 1 }
        lines_missing.slice_when { |prev, curr| curr != prev.next }.to_a
      end

      def export_path
        File.join(SimpleCov.coverage_path, FILENAME)
      end
    end
  end
end
