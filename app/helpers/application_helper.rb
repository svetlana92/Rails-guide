module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    sort_params = params.except(:page).merge sort: column, direction: direction
    link_to title, sort_params, { class: css_class }
  end
end
