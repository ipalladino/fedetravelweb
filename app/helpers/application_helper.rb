module ApplicationHelper
  def make_menu
    if(admin?)
      link = link_to 'Sign out', :controller => 'sessions', :action => 'destroy', :method=>:delete
      html = "<span id='nav-top'>" + link + "  |  <a href='/posts/new'>New Post</a>  |  <a href='/users/'>Users</a>  |  <a href='/posts'>Posts</a></span>"
      render(:inline => html)
    elsif(user?)
      link = link_to 'Sign out', :controller => 'sessions', :action => 'destroy', :method=>:delete
      html = "<span  id='nav-top'>" + link + "</span>"
      render(:inline => html)
    end
  end
end
