class InsertEmployeesService
  def initialize(file)
    @file = file
  end

  def call
    result = { success: true, errors: [] }

    begin
      parser = ExcelParserService.new(@file)
      employee_data = parser.parse

      if employee_data.empty?
        result[:success] = false
        result[:errors] << "The file is empty or has no valid data"
        return result
      end

      upsert_service = EmployeeUpsertService.new(employee_data)
      upsert_errors = upsert_service.upsert

      if upsert_errors.any?
        result[:success] = false
        result[:errors].concat(upsert_errors)
      end

      result
    rescue Roo::FileNotFound => e
      result[:success] = false
      result[:errors] << "File not found: #{e.message}"
      result
    rescue => e
      result[:success] = false
      result[:errors] << "Unexpected error: #{e.message}"
      result
    end
  end
end
