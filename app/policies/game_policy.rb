class GamePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
    def resolve
      scope.where("owner_id = ? OR published_at < ?", user.id, Time.now)
    end
  end
  
  def new?
    user.present?
  end
  
  def play?
    record.published? || (manage? && record.first_paragraph.present?)
  end
  
  def publish?
    manage? && !record.published?
  end
  
  private
  
  def manage?
    user == record.owner
  end
  
  def read?
    manage? || record.published?
  end
end
