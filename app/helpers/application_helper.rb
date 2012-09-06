module ApplicationHelper
  def make_menu
    if(admin?)
      link = link_to 'Sign out', :controller => 'sessions', :action => 'destroy', :method=>:delete
      html = "<div id='nav-top'>" + link + "  |  <a href='/posts/new'>New Post</a>  |  <a href='/users/'>Users</a>  |  <a href='/posts'>Posts</a></div>"
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
    puts "comparing:"
    puts Pathname.new(request.fullpath).basename
    puts type
    if(String(Pathname.new(request.fullpath).basename) == type)
      puts "TRUE"
      #html = "class=\"selected\""
      html = "style=\"color:#ff9900;\""
      render(:inline => html) 
    else
      puts "FALSE"
      return ""
    end
  end
end
