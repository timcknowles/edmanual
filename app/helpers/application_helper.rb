module ApplicationHelper
    def zurb_menu
        menu_items = Refinery::Menu.new(Refinery::Page.in_menu)
        presenter = Refinery::Pages::ZurbMenuPresenter.new(menu_items, self)
        presenter
    end
end
