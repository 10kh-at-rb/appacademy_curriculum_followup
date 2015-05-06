require_relative 'questions_database'
require_relative 'table'

class Reply

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.question_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_reply_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
    SQL

    Reply.new(results.first)
  end

  def self.find_by_replier_id(replier_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, replier_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.replier_id = ?
    SQL

    Reply.new(results.first)
  end

  attr_accessor :id, :question_id, :parent_reply_id, :replier_id, :body

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @replier_id = options['replier_id']
    @body = options['body']
  end

  def author
    User::find_by_user_id(@replier_id)
  end

  def child_replies
    Reply.all.select{|reply| reply.parent_reply_id == @id}
  end

  def parent_reply
    Reply::find_by_reply_id(@parent_reply_id)
  end

  def question
    Question::find_by_question_id(@question_id)
  end



end
