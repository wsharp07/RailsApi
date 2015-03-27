class CustomBreadcrumbs < SimpleNavigation::Renderer::Base
  def render(item_container)
    # we don't want anything if there are no crumbs
    return '' unless number_of_crumbs(item_container) > 1
    content = a_tags(item_container).join(join_with)
    content_tag(:li,
                prefix_for(content) + content)
  end

  # Look up the number of crumbs
  def number_of_crumbs(item_container)
    count = 0
    item_container.items.each do |item|
      next unless item.selected?
      count += 1
    end
    return count
  end
  protected

  def a_tags(item_container)
    item_container.items.each_with_object([]) do |item, list|
      next unless item.selected?
      list << tag_for(item)

      if include_sub_navigation?(item)
        list.concat a_tags(item.sub_navigation)
      end
    end
  end

  def join_with
    @join_with ||= options[:join_with] || ' '
  end

  def suppress_link?(item)
    super || (options[:static_leaf] && item.active_leaf_class)
  end

  def prefix_for(content)
    if !content.empty? && options[:prefix]
      options[:prefix]
    else
      ''
    end
  end

  # Extracts the options relevant for the generated link
  #
  def link_options_for(item)
    if options[:allow_classes_and_ids]
      opts = super
      opts[:id] &&= "breadcrumb_#{opts[:id]}"
      opts
    else
      html_options = item.html_options.except(:class, :id)
      { method: item.method }.merge(html_options)
    end
  end
end