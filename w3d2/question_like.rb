require_relative 'questions_database'

class QuestionLike

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map { |result| QuestionLike.new(result) }
  end

  def self.find_by_question_like_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?
    SQL

    QuestionLike.new(results.first)
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN question_likes ON questions.id = question_like.liked_id
      WHERE
        question_likes.liker_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN question_likes ON users.id = question_likes.liker_id
      WHERE
        question_likes.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes
      JOIN questions ON question_likes.liked_id = questions.id
      GROUP BY
        question_likes.liker_id
      ORDER BY
        COUNT(question_likes.liker_id)
      LIMIT
        ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL

    results.first
  end


  attr_accessor :id, :liker_id, :liked_id

  def initialize(options = {})
    @id = options['id']
    @liker_id = options['liker_id']
    @liked_id = options['liked_id']
  end

end
