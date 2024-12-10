require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    let!(:employee) { create(:employee) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_numericality_of(:age).only_integer.is_greater_than(0) }
  end

  describe 'callbacks' do
    let!(:employee) { create(:employee, email: "JOHN.DOE@EXAMPLE.COM") }
    
    it 'downcases email before saving' do
      expect(employee.email).to eq("john.doe@example.com")
    end
  end
end