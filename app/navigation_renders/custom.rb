class Custom < SimpleNavigation::Renderer::Base
  def render(item_container)
    list_content = item_container.items.inject([]) do |list, item|
      li_options = item.html_options.reject {|k, v| k == :link || k == :icon}

      if (item_container.level == 1)
        li_content = build_primary(item)
      else
        li_content = build_nested(item)
      end
      if has_sub_navigation?(item)
        #li_content << render_sub_navigation_for(item)
        li_content << build_sub_nav(item)
      end
      list << content_tag(:li, li_content, li_options)
    end.join
    if skip_if_empty? && item_container.empty?
      ''
    else
      if (item_container.level == 1)
        content_tag(
            (options[:ordered] ? :ol : :ul),
            list_content,
            {
                :id => item_container.dom_id,
                :class => item_container.dom_class,
                :'data-keep-expanded' => 'false',
                :'data-auto-scroll' => 'true',
                :'data-slide-speed' => '200'
            })
      else
        content_tag(
            (options[:ordered] ? :ol : :ul),
            list_content,
            {
                :id => item_container.dom_id,
                :class => 'sub-menu'
            })
      end
    end
  end

  def build_primary(item)
    @arr = []
    @arr.push("<a href='#{item.url}'>")
    @arr.push("<i class='#{item.html_options[:icon]}'></i>")
    @arr.push("<span class='title'>#{item.name}</span>")

    # throw an arrow down if we have sub nav
    if has_sub_navigation?(item)
      @arr.push("<span class='arrow'></span>")
    end

    @arr.push('</a>')
    return @arr.join("\n")
  end

  def build_nested(item)
    @arr = []
    @arr.push("<a href='#{item.url}'>#{item.name}</a>")
    return @arr.join("\n")
  end

  def has_sub_navigation?(item)
    return false unless item.sub_navigation

    case level
      when :all then true
      when Range then item.sub_navigation.level <= level.max
      else false
    end
  end

  def build_sub_nav(item)
    item.sub_navigation.render(options)
  end
end