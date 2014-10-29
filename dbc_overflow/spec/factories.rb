FactoryGirl.define do
  factory :question do
    title "my test question title"
    content "my test question body"
  end

  factory :answer do
    title "my test answer title"
    content "my test answer body"
  end
end
