10.times do
  question = Question.create(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph
  )

  5.times do
    question.answers.create(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph
    )
  end
end
