require "csv"
require "./url_matcher"
require "./spreadsheet_exporter"

class UrlChecker
  TARGET_FILE = "output.xls"

  attr_reader :source_file, :target_file

  def initialize(source_file, target_file = TARGET_FILE)
    @source_file = source_file
    @target_file = target_file
  end

  def write
    spreadsheet_exporter.new(entries, target_file).export
  end

  def entries
    source_entries.map { |url| url_matcher.new(url).match }
  end

  def source_entries
    @_source_entries ||= CSV.new(source_data).to_a.map { |e| e[0] }
  end

  def source_data
    @_source_data ||= File.read(source_file)
  end

  def url_matcher
    UrlMatcher
  end

  def spreadsheet_exporter
    SpreadsheetExporter
  end
end

UrlChecker.new("links.csv").write
