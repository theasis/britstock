module PhotographersHelper
  def optional(label)
    sanitize(t(label)+" <span class='optional'>"+t(:application_form_label_optional_field)+"</span>")
  end
end
