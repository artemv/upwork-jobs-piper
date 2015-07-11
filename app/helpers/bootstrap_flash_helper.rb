# based on  https://github.com/seyhunak/twitter-bootstrap-rails project
module BootstrapFlashHelper

  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |alert_type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      flash_messages << bootstrap_alert(message, options.merge(alert_type: flash_alert_type_to_bootstrap(alert_type),
                                                               dismissible: true))
    end
    flash_messages.join("\n").html_safe
  end

  def flash_alert_type_to_bootstrap(flash_alert_type)
    flash_alert_type = flash_alert_type.to_sym
    flash_alert_type = :success if flash_alert_type == :notice
    flash_alert_type = :danger if flash_alert_type == :alert
    flash_alert_type = :danger if flash_alert_type == :error
    flash_alert_type = nil unless ALERT_TYPES.include?(flash_alert_type)
    flash_alert_type
  end

  def bootstrap_alert(message, options = {})
    alert_type = options.delete(:alert_type)
    tag_class = options.delete(:class)
    dismissible = options[:dismissible]
    tag_classes = build_tag_classes(alert_type, dismissible, tag_class)
    tag_options = { class: tag_classes }.merge(options)

    close_button = bootstrap_close_button(options[:close_button_title], dismissible)

    content_tag(:div, close_button + message.html_safe, tag_options)
  end

  def build_tag_classes(alert_type = nil, dismissible = nil, tag_class = nil)
    tag_classes = ["alert"]
    tag_classes << "alert-dismissible" if dismissible

    # don't enable animation for test env - it makes capybara tests unstable
    tag_classes += %w(fade in) unless Rails.env.test?

    tag_classes << tag_class if tag_class
    tag_classes << "alert-#{alert_type}" if alert_type
    tag_classes
  end

  def bootstrap_close_button(title, dismissible = true)
    title ||= "Close"
    x = content_tag(:span, raw("&times;"), "aria-hidden" => "true")
    a = { class: "close", "aria-label" => title, :value => title }
    a.merge!("data-dismiss" => "alert") if dismissible
    content_tag(:button, x, { type: "button" }.merge(a))
  end

end
