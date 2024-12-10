# spec/services/insert_employees_service_spec.rb
require 'rails_helper'

RSpec.describe InsertEmployeesService, type: :service do
  describe '#call' do
    let(:service) { described_class.new(file) }

    context 'when the file is valid' do
      let(:file) { fixture_file_upload('employees.xlsx', 'application/vnd.ms-excel') }

      it 'returns success' do
        result = service.call
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end

      it 'creates employees' do
        expect { service.call }.to change(Employee, :count).by(1)
      end
    end

    context 'when the file is empty' do
      let(:file) { fixture_file_upload('empty.xlsx', 'application/vnd.ms-excel') }

      it 'returns an error' do
        result = service.call
        expect(result[:success]).to be false
        expect(result[:errors]).to include("The file is empty or has no valid data")
      end
    end

    context 'when the employee is already created' do
      let(:file) { fixture_file_upload('employees.xlsx', 'application/vnd.ms-excel') }
      let!(:employee) { create(:employee, email: 'mark@email.com') }

      it 'returns success' do
        result = service.call
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end
  end
end
