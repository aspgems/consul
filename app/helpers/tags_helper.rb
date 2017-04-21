module TagsHelper

  def taggable_path(taggable_type, tag_name)
    case taggable_type
    when 'debate'
      debates_path(search: tag_name)
    when 'proposal'
      proposals_path(search: tag_name)
    else
      '#'
    end
  end

  def nav_element(match_controller, path = root_path, legend = '', options = {}, &block)
    tag_name = options.delete(:tag_name) || :li
    class_icon = options.delete(:class_icon) || 'icon-eye'
    class_active = options.delete(:class_active) || 'active'
    options[:class] = "#{options[:class]} #{class_active}" if controller_name == match_controller

    if block_given?
      content = capture(&block)
    else
      icon = content_tag(:span, nil, class: class_icon)
      text = t(legend, scope: 'admin.menu')
      content = link_to(safe_join([icon, text]), path)
    end

    content_tag(tag_name, content, options)
  end

end
