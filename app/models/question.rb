class Question < ApplicationRecord

  # validates :title, presence: { message: 'must be given!' }
  validates(:title, { presence: { message: 'must be given!' },
                      uniqueness: true })
  validates :body, presence: true, length: { minimum: 3 }
  validates :view_count, presence: true,
                         numericality: { greater_than_or_equal_to: 0 }

  # when use `validates` with an `s` then Rails expect one of the Rails built-in
  # validation options such as: :presense, :uniqueness, :numericality..etc

  # if you want to write a custom validation method then you will need to use
  # `validate` (no s)
  validate :no_monkey

  private

  def no_monkey
    if title.present? && title.downcase.include?('monkey')
      errors.add(:title, 'No monkeys please!')
    end
  end

end
