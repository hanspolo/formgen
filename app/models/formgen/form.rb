require 'csv'

module Formgen
  class Form < ActiveRecord::Base
    include Etikett::Taggable

    has_many_via_tags :context, class_names: ['Council', 'Course', 'Facility', 'Faculty', 'Global']

    has_many :questions, inverse_of: :form, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    has_many :replies, dependent: :destroy

    def to_csv
      CSV.generate(force_quotes: true) do |csv|
        csv << self.questions.outputable.map(&:value)
        self.replies.each do |reply|
          csv << reply.answers.outputable.map(&:value)
        end
      end
    end
  end
end
