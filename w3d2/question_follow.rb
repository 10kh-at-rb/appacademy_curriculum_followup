require_relative 'questions_database'

class QuestionFollow
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    results.map { |result| QuestionFollow.new(result) }
  end

  def self.find_by_question_follow_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_follows.id = ?
    SQL

    QuestionFollow.new(results.first)
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN question_follows ON questions.id = question_follows.question_id
      WHERE
        question_follows.follower_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN question_follows ON question_follows.follower_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        questions
      JOIN question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.follower_id)
      LIMIT
        ?
    SQL

    results.map { |result| Question.new(result)}
  end

  attr_accessor :id, :follower_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end



end
