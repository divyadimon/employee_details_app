Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/employees', to: "employees#create"
  get '/employees/tax_deductions', to: "employees#tax_deduction"
end
