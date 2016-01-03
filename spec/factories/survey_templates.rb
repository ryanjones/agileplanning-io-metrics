FactoryGirl.define do
  factory :survey_template do
    sequence(:name) { |k| "Survey Template #{k}" }
    description Forgery(:lorem_ipsum).words(12)
    organization
  end

end
