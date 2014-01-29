class CompanyForm < Powertools::Reform
  model :company

  property :name, type: String
end
