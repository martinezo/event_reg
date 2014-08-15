module ApplicationHelper

  def sortable(column, title=nil, url)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    (column == sort_column && sort_direction == "asc") ? title << " \u25B2" : title << " \u25BC"
    link_to title, "#{url}?direction=#{direction}&sort=#{column}" << (params[:search] ? "&search=#{params[:search]}" : ''), remote: true, class: 'sortable'
  end

  def link_to_jq_button(options)
    url = options[:url]
    text = options[:text] || '&nbsp'.html_safe
    jq_text = !options[:text].nil?
    title = options[:title] || nil
    remote = options[:remote].nil? ? true : options[:remote]
    data = options[:data] || nil
    icon = options[:icon] || nil
    id = options[:id] || nil
    html_class = 'jq-button' << (options[:html_class] ? ", #{options[:html_class]}" : '')
    target = options[:target] || nil
    link_to text, url, title: title, remote: remote, data: data, 'jq-icon'=> icon, id: id, class: html_class, 'jq-text' => jq_text, target: target
  end


  def jq_submit_tag(title, data=nil)
    submit_tag title, :'jq-text' => true, :class => 'jq-button', data: data
  end

  # TODO remove commented lines if methods are not used
  # def jq_link_to(url, text, icon = nil , title = nil, remote = true)
  #   link_to text, url, :title => title, :remote => remote, :'jq-text' => true, :'jq-icon' => icon, :class => 'jq-button', data: { disable_with: 'Procesando...'}
  # end
  #
  # def jq_icon_link_to(url, icon, title='&nbsp'.html_safe, remote = true)
  #   link_to title, url, :remote => remote, :'jq-icon' => icon, :class => 'jq-button'
  # end
  #
  # def jq_link_to_destroy(url, text=nil, confirm = t('crud.confirm'), title='&nbsp'.html_safe, remote = true)
  #   link_to text.nil? ? "&nbsp".html_safe : text, url, :remote => remote, :'jq-icon' => 'trash', :class => 'jq-button', :'jq-text' => !text.nil?, :method => :delete, :data => { :confirm => confirm }
  # end

end
