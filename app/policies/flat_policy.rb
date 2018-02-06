class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(city: user.cities)
    end
  end

  def show?
    true
  end

  def index?
    true
  end
end
