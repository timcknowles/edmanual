module ApplicationHelper


  def zurb_menu
    menu_items = Refinery::Menu.new(Refinery::Page.in_menu)
 
    presenter = Refinery::Pages::MenuPresenter.new(menu_items, self)
    presenter.css = "top-bar-section"
    presenter.dom_id = nil
    presenter.menu_tag = :section
    #presenter.list_tag = "li class='has-dropdown'"
    #presenter.list_item_tag = "ul class='dropdown'"
    presenter
  end
end
