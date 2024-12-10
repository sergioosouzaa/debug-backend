class EmployeeUpsertService
  def initialize(employee_data)
    @employee_data = employee_data
  end

  def upsert
    errors = []

    @employee_data.each_with_index do |data, index|
      begin
        upsert_employee(data[0], data[1], data[2])
      rescue ActiveRecord::RecordInvalid => e
        errors << { line: index + 2, message: "Validation failed: #{e.record.errors.full_messages.join(', ')}" }
      rescue => e
        errors << { line: index + 2, message: "Unexpected error: #{e.message}" }
      end
    end

    errors
  end

  private

  def upsert_employee(name, email, age)
    employee = Employee.find_or_initialize_by(email: email.downcase)
    employee.assign_attributes(
      name: name,
      age: age
    )
    employee.save!
  end
end
