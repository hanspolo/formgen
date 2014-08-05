module Formgen
  #
  class FormTabulatrData < Tabulatr::Data
    buttons do |b, r|
      b.button :eye,  formgen.form_path(r.id)
      b.button :pencil, formgen.edit_form_path(r.id)
      b.submenu do |s|
        s.button :times, formgen.form_path(record.id), label: I18n.t('formgen.action.delete'), method: :delete, data: { confirm: I18n.t('formgen.action.are_you_sure')}
      end
    end

    column :title
    column :path
    column :questions, table_column_options: { sortable: false, filter: false } do |record|
      record.questions.count.to_s
    end
    column :answers, table_column_options: { sortable: false, filter: false } do |record|
      record.replies.count.to_s
    end
    column :context_tags, table_column_options: { filter: false, sortable: false } do |f|
      f.context_tags.map(&:name).join(' & ')
    end
  end
end
