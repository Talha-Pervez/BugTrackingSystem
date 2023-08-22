class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Guest user

    if user.manager?
      can :manage, Project, manager_id: user.id
      can :read, Bug, project: { manager_id: user.id }
    elsif user.qa?
      can :read, Project, user_projects: { user_id: user.id }
      can [:read,:create], Bug
      can :manage, Bug, qa_id: user.id
    elsif user.developer?
      can :read, Project, user_projects: { user_id: user.id }
      can :read, Bug
      can :update, Bug, developer_id: user.id
    end
  end
end
