#encoding: utf-8
module SessionsHelper

  def sign_in(user)
    cookies.signed[:remember_token] ={ :value => [user.id, user.salt], :expires => 12.hour.from_now}
    self.current_user = user
  end
  
  def sign_out
    cookies.delete :remember_token
    self.current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def authenticate
  	#dodajemy sobie controllery i akcje ktore sa dopuszczone dla niezalogowanego usera
  	controllers = ["welcome", "users", "sessions", "auctions", "blogposts"]
    actions = ["new","backend_new", "create","backend_create", "index", "search", "result", "mail_ver", "show", "find","get_vercode"]
  	if controllers.include?(params[:controller]) && actions.include?(params[:action])
  		return
    else
      deny_access unless signed_in?
    end
  end
  
  def deny_access
  	store_location
    if params[:controller] =~ /case/
      redirect_to backend_new_sessions_path, :notice => "请登录浏览此页面"
    else
      redirect_to signin_path, :notice => "请登录浏览此页面"
    end

  end
  
  def current_user?(user)
    user == current_user
  end

  def redirect_back_from_login(default)
    logger.debug "--------------redirect_back_from_login"
    redirect_to session[:return_to] || root_path, :notice => "你好 #{current_user.name}!"
    clear_return_to
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end