module ApplicationHelper
  def flash_messages
    list = flash.map do |level, message|
      content_tag(:div, class: "alert alert-#{message_level(level)}") do
        content_tag(:span, message, class: 'message')
      end
    end

    safe_join(list)
  end

  def error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    _error_messages(messages)
  end

  def error_messages_for_service(object)
    _error_messages(object.errors.uniq) if object
  end

  def _error_messages(messages)
    return if messages.blank?

    content_tag(:div, class: "alert alert-#{message_level :error}") do
      list_items = messages.map { |m| content_tag(:li, m) }
      content_tag(:ul, safe_join(list_items), class: 'list-unstyled')
    end
  end

  # Twitter Bootstrap用にクラス名を変換する
  def message_level(level)
    case level.to_sym
    when :notice then :success
    when :alert then :warning
    when :error then :danger
    end
  end
end
