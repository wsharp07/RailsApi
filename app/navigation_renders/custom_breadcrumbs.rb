class CustomBreadcrumbs < SimpleNavigation::Renderer::Base
  def render(item_container)
    # we don't want anything if there are no crumbs
    return '' unless number_of_crumbs(item_container) > 0
    content = get_crumbs(item_container)
    content_tag(:li, build_crumbs(content))
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

  def get_crumbs(item_container)
    item_container.items.each_with_object([]) do |item, list|
      next unless item.selected?
      list << {name: item.name, url: item.url}

      if include_sub_navigation?(item)
        data = get_crumbs(item.sub_navigation)
        list << data[0]
      end
    end
  end

  def build_crumbs(crumbs)
    return unless crumbs.length > 0

    tagArray = Array.new
    len = crumbs.length - 1
    for i in 0..len
      tagArray.push('<li>')
      tagArray.push('<a href="' + crumbs[i][:url].to_s + '">')
      tagArray.push(crumbs[i][:name].to_s)
      tagArray.push('</a>')
      tagArray.push('<i class="fa fa-circle"></i>') unless i == len
      tagArray.push('</li>')
    end
    return tagArray.join('')
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