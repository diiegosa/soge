module MenuHelper

  def make_menu
    default_icon = 'far fa-circle '
    [
      { model: 'Usuários', icon: 'fa fa-users', children:
        [
          {model: 'User', action: :index, path: 'users', icon: default_icon, children: []},
          {model: 'Profile', action: :index, path: 'profiles', icon: default_icon, children: []}
        ]
      },
    ]
  end

  def navlink_active?(item)
    item[:path] == controller_name ? "active" : nil
  end
  
  def treeview_active?(item)
    item[:children].each do |item|
      return "menu-open" unless navlink_active?(item).nil?
    end
  end

  def has_items?(children)
    has = false
    children.each do |item|
      if can?(item[:action].to_sym, item[:model].constantize)
        has = true
        break
      end
    end
    return has
  end
end
