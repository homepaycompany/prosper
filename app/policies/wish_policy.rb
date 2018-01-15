class WishPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.(user: current_user)
    end
  end
end
