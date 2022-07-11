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
        # assume line 0 is covered as well as the end of file, filter skipped coverage
        lines_coverage = [1] + file.lines.map { |l| l.skipped? ? 1 : l.coverage } + [1]
        lines_coverage = fill_blank_lines(lines_coverage)
        lines_missing = lines_coverage.each_index.select { |index| lines_coverage[index].zero? }
        lines_missing.slice_when { |prev, curr| curr != prev.next }.to_a
      end

      def fill_blank_lines(lines)
        forward = fill_missing(lines.dup)
        backward = fill_missing(lines.reverse).reverse

        [forward, backward].transpose.map(&:compact).map(&:max)
      end

      def fill_missing(lines)
        lines.each_index do |index|
          next if index.zero?
          next unless lines[index].nil?

          lines[index] = lines[index - 1]
        end
      end

      def export_path
        File.join(SimpleCov.coverage_path, FILENAME)
      end
    end
  end
end
