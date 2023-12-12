class Employee < ApplicationRecord
	has_one :tax_deduction, dependent: :destroy
	validates :first_name, :last_name, :email, :salary, :date_of_joining, :phone_number, presence: true
	validates :email, uniqueness: true

	before_create :set_employee_code
	after_commit :set_tax_deduction

	private

	def set_employee_code
	  self.employee_code = generate_employee_code
	end

	def generate_employee_code
	   loop do
	     	number = SecureRandom.random_number(10000000)
	     	employee_code = self.first_name.upcase + "#{number}"

	     	break employee_code unless Employee.where(employee_code: employee_code).exists?
		end
	end

	def set_tax_deduction
		start_date = get_fiscal_year_start(self.date_of_joining)
		end_date = get_fiscal_year_end(self.date_of_joining)
		between_of_may =  start_date + 45.days
		doj = self.date_of_joining
		salary = self.salary
		if start_date > doj
			package = (salary / 30) * 365
		else
			days = (end_date - doj).seconds.in_days
			package = (salary / 30) * days
		end
		tax_amount = calculate_tax_slab(package)
		if package > 2500000
			amount = package - 2500000
			cess_amount = amount * 0.02
		else
			cess_amount = 0
		end
		self.create_tax_deduction(salary: salary * 12, tax_amount: tax_amount, cess_amount: cess_amount)
	end

	def calculate_tax_slab(year_package)
		
		if year_package > 1000000
			tax_amount = 12500 + 25000 + 37500 + ((year_package - 1000000) * 0.2)
		elsif year_package > 500000 && year_package <= 1000000
			tax_amount = 12500 + 25000 + ((year_package - 500000) * 0.15) 
		elsif year_package > 250000 && year_package <= 500000
			tax_amount = 12500 + ((year_package - 250000) * 0.1)
		else
			tax_amount = 0
		end
		return tax_amount
	end


	def get_fiscal_year_start(date)
  		date = date.change(year: date.year - 1) if date.month < 4
  		date.change(month: 4).beginning_of_month
	end
 

	def get_fiscal_year_end(date)
	  date = date.change(year: date.year + 1) if date.month > 3
	  date.change(month: 3).end_of_month
	end
end
