class Table

  def self.table_query(table_name, row_val)
    results = QuestionsDatabase.instance.execute(<<-SQL, table_name, row_val)
      SELECT
        *
      FROM
        ? AS table
      WHERE
        table = ?
    SQL

    results
  end

end
