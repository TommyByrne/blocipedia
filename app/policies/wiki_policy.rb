class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def index?
      true
    end

    def show?
      if user
        (user.role == 'admin') || record.users.include?(user) || (user == record.user) || (record.private == nil)
      else
        record.private == nil
      end
    end

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user == nil
        scope.none
      elsif user.role == "admin" || "premium"
        scope.all
      elsif
        scope.eager_load(:collaborators)
        .where("wikis.user_id = ? OR private = ? OR collaborators.user_id = ?", user, false, user)
      else
        scope.where(private: nil)
      end
    end
  end
end