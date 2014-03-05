module ApplicationHelper

  #
  #  useage
  # link_to 'Title', xyz_path, class: active_page('action_name')
  #
  def active_page(page_name)
    'active' if params[:action] == page_name
  end

end
