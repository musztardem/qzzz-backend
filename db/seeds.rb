
users = [
  { username: 'janek', email: 'janek@email.com', password: 'plokplok', password_confirmation: 'plokplok' },
  { username: 'tomek', email: 'tomek@email.com', password: 'plokplok', password_confirmation: 'plokplok' },
  { username: 'romek', email: 'romek@email.com', password: 'plokplok', password_confirmation: 'plokplok' },
]

users.each { |u| User.create!(u) }
puts "Users created..."

Friendship.create!(user: User.first, friend: User.last)
puts "Friendship created..."

quizzes = [
  {
    title: 'Musicians',
    description: 'Quiz about famous musicians!',
    questions: [
      {
        content: 'Tom Araya is singer of which band?',
        answers: [
          {
            content: 'Slayer',
            correct: true
          },
          {
            content: 'Metallica',
            correct: false
          },
          {
            content: 'Anthrax',
            correct: false
          },
          {
            content: 'Testament',
            correct: false
          },
        ]
      },
      {
        content: 'Which of the bands is NOT in the big 4?',
        answers: [
          {
            content: 'Slayer',
            correct: false
          },
          {
            content: 'Metallica',
            correct: false
          },
          {
            content: 'Anthrax',
            correct: false
          },
          {
            content: 'Testament',
            correct: true
          },
        ]
      }
    ]
  },
  {
    title: 'Programming',
    description: 'Quiz about programming!',
    questions: [
      {
        content: 'Which programming language is Ruby?',
        answers: [
          {
            content: 'Ruby',
            correct: true
          },
          {
            content: 'Java',
            correct: false
          },
          {
            content: 'JavaScript',
            correct: false
          },
          {
            content: 'Perl',
            correct: false
          }
        ]
      },
      {
        content: 'Which programming language has Ruby in logo?',
        answers: [
          {
            content: 'Ruby',
            correct: true
          },
          {
            content: 'Java',
            correct: false
          },
          {
            content: 'JavaScript',
            correct: false
          },
          {
            content: 'Perl',
            correct: false
          }
        ]
      },
    ]
  }
]

quizzes.each do |quiz|
  qz = Quiz.create(user: User.last, title: quiz[:title], description: quiz[:description])
  questions = quiz[:questions]
  questions.each do |question|
    qs = Question.create!(quiz: qz, content: question[:content])
    answers = question[:answers]
    answers.each do |answer|
      Answer.create(question: qs, content: answer[:content], correct: answer[:correct])
    end
  end
end
puts "Quizzes created..."
