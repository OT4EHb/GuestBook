# :nodoc:
class Message < ApplicationRecord
  validates :author,
            presence: true
  validates :text,
            presence: true,
            length: { minimum: 3 }

  default_scope { order(created_at: :desc) }
end
