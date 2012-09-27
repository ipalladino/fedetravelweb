module ApplicationHelper
  def make_menu
    if(admin?)
      link = link_to 'Sign out', :controller => 'sessions', :action => 'destroy', :method=>:delete
      html = "<div id='nav-top'>" + link + "  |  <a href='/posts/new'>New Post</a>  |  <a href='/users/'>Users</a>  |  <a href='/posts'>Posts</a> | <a href='/'>Start</a> | <a href='/map_location/manage'>Manage Locations</a></div>"
      render(:inline => html)
    elsif(user?)
      link = link_to 'Sign out', :controller => 'sessions', :action => 'destroy', :method=>:delete
      html = "<div  id='nav-top'>" + link + "</div>"
      render(:inline => html)
    end
  end
  def showPost(counter = 0)
    @isAdmin = admin?
    @counter = counter
    render '/posts/img_vid_map'
  end
  
  def make_menu_page
    render '/layouts/menu'
  end
  
  def isSelected?(type)
    if(String(Pathname.new(request.fullpath).basename) == type)
      #html = "class=\"selected\""
      html = "style=\"color:#ff9900;\""
      render(:inline => html) 
    else
      return ""
    end
  end
  
  def renderMap
    if admin?
      render '/map_location/show_admin'
    else
      render '/map_location/show_user'
    end
  end
end
