class ChoicePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  end
  
  private
  
  def manage?
    user.present? && user == record.game.owner
  end
  
  def read?
    record.game.published? || user == record.game.owner
  end
end
