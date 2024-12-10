class ExcelParserService
  def initialize(file)
    @file = file
  end

  def parse
    spreadsheet = Roo::Spreadsheet.open(@file.tempfile.path)

    header = spreadsheet.row(1)
    data = []
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      data << row
    end

    data
  end
end
