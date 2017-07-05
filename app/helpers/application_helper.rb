module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Review Systeam'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def active_class options
    active =
      (!options[:c] || (options[:c] == params[:controller])) &&
      (!options[:a] || (options[:a].include? params[:action])) &&
      (!options[:id] || (options[:id].to_s == params[:id]))
    active ? 'active' : false
  end
end
