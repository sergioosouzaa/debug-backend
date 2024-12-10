class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def bulk_insert
    if params[:file].blank?
      return render json: { error: "No file provided" }, status: :unprocessable_entity
    end

    service = InsertEmployeesService.new(params[:file])
    result = service.call

    if result[:success]
      flash[:notice] = "Employees processed successfully"
    else
      flash[:alert] = "Errors occurred while processing employees"
      flash[:errors] = result[:errors]
    end

    redirect_to employees_path
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :age)
  end
end
