class AccessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def access_request?
    true
  end
end
