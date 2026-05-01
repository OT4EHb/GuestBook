# frozen_string_literal: true

require 'sqlite3'

# database, table messages
class Message
  def initialize(database)
    @db = SQLite3::Database.new "#{database}.db"
    @db.results_as_hash = true
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS messages (
        id INTEGER PRIMARY KEY,
        author TEXT NOT NULL,
        text TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    SQL
  end

  def all
    @db.execute <<-SQL
        SELECT * FROM messages
        ORDER BY created_at DESC
    SQL
  end

  def create(author, text)
    @db.execute("
        INSERT INTO messages
        (author, text)
        VALUES (?, ?)",
                [author, text])
  end

  def delete(id)
    @db.execute("
            DELETE FROM messages
            WHERE id = ?",
                [id])
  end
end
