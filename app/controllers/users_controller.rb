class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout "sign"
  skip_filter :login_required

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
	@user.time_zone = 'Kyev'
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_to login_path
      flash[:notice] = "Дякуємо за реєстрацію! На Вашу адресу надіслано лист із кодом активації."
    else
      flash[:error]  = "На жаль, не вдалося створити Ваш обліковий запис.  Будь-ласка, спобуйте ще раз або зв'яжіться із адміністратором."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Реєстрація завершена! Увійдіть у свій обліковий запис, щоб почати роботу."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "Код активації відсутній.  Будь-ласка перейдіть по посиланню із отриманого листа."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "Не вдалося знайти користувача із таким кодом активації -- Ви перевірили свою скриньку? Або, можливо, Ви уже активували свій обліковий запис -- спробуйте увійти."
      redirect_back_or_default('/')
    end
  end

  def edit
    @user = current_user
    render :layout => "application"
  end

  def update
    @user = current_user
    @user.time_zone = params[:user][:time_zone]
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Налаштування збережено."
    else
      flash[:error]  = "Не вдалося зберегти зміни."
      render :action => 'edit'
    end
  end
end
