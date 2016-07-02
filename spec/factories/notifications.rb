FactoryGirl.define do
  factory :notification do
    user nil
    post nil
    subscribed_user nil
    identifier 1
    type ""
    read false
  end
end
