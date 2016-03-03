require 'spreadsheet'

class SpreadsheetExporter
  attr_reader :filename, :entries

  def initialize(entries, filename)
    @entries = entries
    @filename = filename
  end

  def export
    worksheet
    insert_entries
    book.write(filename)
  end

  def insert_entries
    entries.each_with_index do |n, index|
      book.worksheet(0).insert_row(index, [n[0], n[1]])
    end
  end

  def book
    @book ||= Spreadsheet::Workbook.new
  end

  def worksheet
    @worksheet ||= book.create_worksheet :name => 'Sheet Name'
  end
end
