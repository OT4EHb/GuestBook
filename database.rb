# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'guestbook.db'
)

# model message
class Message < ActiveRecord::Base
  validates :author,
            presence: true
  validates :text,
            presence: true,
            length: { minimum: 3 }

  default_scope { order(created_at: :desc) }
end

unless ActiveRecord::Base.connection.tables.include?('messages')
  ActiveRecord::Schema.define do
    create_table :messages do |t|
      t.string :author, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end
