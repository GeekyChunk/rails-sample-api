class LoginValidator < Dry::Validation::Contract
  params do
    required(:username).filled(:string)
    required(:password).filled(:string)
  end
end
