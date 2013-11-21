module Refinery
  module Pages
    class ZurbMenuPresenter < MenuPresenter

    config_accessor :list_dropdown_css, :list_item_dropdown_css, :list_first_css

    MenuPresenter.menu_tag = :section
    MenuPresenter.css = "top-bar-section"
    self.list_dropdown_css = "dropdown"
    self.list_item_dropdown_css = "has-dropdown"
    self.list_first_css = nil

      def render_menu_items(menu_items)
        if menu_items.present?
          content_tag(list_tag, :class => menu_items_css(menu_items)) do
            menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
              buffer << render_menu_item(item, index)
            end
          end
        end
      end


      def check_for_dropdown_item(menu_item)
        ( menu_item != roots.first ) && ( menu_item_children( menu_item ).count > 0 )
      end

      def menu_items_css(menu_items)
        css = []

        css << list_first_css if (roots == menu_items)
        css << list_dropdown_css if (roots != menu_items)

        css.reject(&:blank?).presence

      end


      def menu_item_css(menu_item, index)
        css = []

        css << list_item_dropdown_css if (check_for_dropdown_item(menu_item))
        css << selected_css if selected_item_or_descendant_item_selected?(menu_item)
        css << first_css if index == 0
        css << last_css if index == menu_item.shown_siblings.length

        css.reject(&:blank?).presence
      end

      def render_menu_item(menu_item, index)

          if check_for_dropdown_item(menu_item)
              menu_item_class = list_item_dropdown_css
          else
              menu_item_class =  menu_item_css(menu_item, index)
          end

          content_tag(list_item_tag, :class => menu_item_class) do
              @cont = context.refinery.url_for(menu_item.url)
              buffer = ActiveSupport::SafeBuffer.new
              buffer << link_to(menu_item.title, context.refinery.url_for(menu_item.url))
              buffer << render_menu_items(menu_item_children(menu_item))
              buffer
          end
      end


    end
  end
end