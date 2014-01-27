class CompanyForm < Reform::Form
  model :company

  property :name, type: String
end
