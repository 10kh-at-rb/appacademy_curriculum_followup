require 'sqlite3'
require 'singleton'
require_relative 'user'
require_relative 'question'
require_relative 'question_follow'
require_relative 'reply'
require_relative 'question_like'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

if __FILE__ == $PROGRAM_NAME
  a = User.find_by_user_id(1)
  p a.average_karma
end
