require_relative 'questions_database'

class User

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?
    SQL

    User.new(results.first)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    User.new(results.first)
  end

  attr_accessor :fname, :lname, :id

  def initialize(options = {})
    @fname, @lname, @id = options['fname'], options['lname'], options['id']
  end

  def authored_questions
    Question::find_by_author_id(@id)
  end

  def authored_replies
    Reply::find_by_replier_id(@id)
  end

  def average_karma
    QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_likes.liker_id) AS FLOAT) /
        COUNT(DISTINCT(questions.id)) karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.liked_id
      WHERE
        questions.author_id = ?
    SQL
  end

  def followed_questions
    QuestionFollow::followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def save
    params = [@fname, @lname]
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        UPDATE
          users
        SET
          fname = ?, lname = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end
end
