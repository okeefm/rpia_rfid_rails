class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    
    if user.has_role? :admin
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard              # grant access to the dashboard
      can :manage, :all
    end
    
  end
end
