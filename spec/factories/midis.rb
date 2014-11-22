FactoryGirl.define do
  factory :midi do
    sequence(:name) { |i| "Such MIDI #{i}" }
    file File.open('./spec/fixtures/jingle-bells.mid')
  end
end
