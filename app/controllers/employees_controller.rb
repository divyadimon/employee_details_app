class EmployeesController < ApplicationController

	def create
		@employee = Employee.new(employee_params)
		if @employee.save
			render json: { employees: @employee },status: 200
		else
			render json: { message: @employee.errors.messages }, status: 400
		end
	end

	def tax_deduction
		employees = Employee.includes(:tax_deduction)
		result = employees.map do |employee|
			tax_deduction = employee.tax_deduction
			employee.attributes.slice('employee_code','first_name','last_name').merge(salary: tax_deduction.salary,
				                                                                      tax_amount: tax_deduction.tax_amount&.round(2),
				                                                                      cess_amount: tax_deduction.cess_amount&.round(2))
		end
		render json: { employees: result }, status: 200
	end

	private
	def employee_params
		params.require(:employees).permit(:first_name,:last_name,:date_of_joining,:salary,:email, :phone_number, :alternate_number)
	end
end