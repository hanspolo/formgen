module Formgen
  class Form < ActiveRecord::Base
    has_many :questions, inverse_of: :form, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    has_many :replies, dependent: :destroy
    
    validates :title, presence: true

    def to_csv
      CSV.generate do |csv|
        csv << self.questions.map(&:value)
        self.replies.each do |reply|
          csv << reply.answers.map(&:value)
        end
      end
    end
  end
end
