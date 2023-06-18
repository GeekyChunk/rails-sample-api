class UserValidator < Dry::Validation::Contract
  params do
    required(:username).filled(:string)
    required(:name).filled(:string)
    required(:password).filled(:string)
  end

end
