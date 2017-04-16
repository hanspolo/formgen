require 'csv'

module Formgen
  ##
  # Forms are the basic model of formgen.
  # They are created and embedded into the site.
  #
  class Form < ActiveRecord::Base
    has_many :questions, inverse_of: :form, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    has_many :replies, dependent: :destroy
    
    validates :title, presence: true

    def to_csv
      CSV.generate(force_quotes: true) do |csv|
        csv << self.questions.outputable.map(&:value) + [I18n.t('activerecord.attributes.formgen/form.created_at')]
        self.replies.each do |reply|
          csv << reply.answers.outputable.map(&:value) + [I18n.l(reply.created_at)]
        end
      end
    end
  end
end
