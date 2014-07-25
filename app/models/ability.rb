class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role
      when 1
        can :manage, :all
      when 2
        can :manage, Catalogs::Course, :user_id => user.id
        #nested condition: participant belongs to course and course belongs to user
        can :manage, Catalogs::Participant, :course => {:user => {:id => user.id}}
        cannot :manage, Admin::User
      when 3
        can :read, Catalogs::Courses
    end
    can :read, :all
  end
end