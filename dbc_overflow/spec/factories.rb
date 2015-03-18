FactoryGirl.define do
  factory :question do
    title {'Nichole is the greatest tester of all time'}
    content {'Nyan cat is the perdiest'}
  end

  factory :answer do
    id {1}
    title {'Here is an answer'}
    content {'I am grumpy as fuck about testing'}
  end
end
