class MunicipalityPolicy < ApplicationPolicy
  # https://github.com/varvet/pundit
  # See ApplicationPolicy for defaults

  def index?
    super || user.admin?
    # account_user.admin? || account_user.member?
  end

  # def show?
  #   account_user.admin? || account_user.member?
  # end
  #
  # def create?
  #   account_user.admin? || account_user.member?
  # end
  #
  # def update?
  #   account_user.admin? || account_user.member?
  # end
  #
  # def destroy?
  #   account_user.admin? || account_user.member?
  # end

  # https://github.com/varvet/pundit#strong-parameters
  # def permitted_attributes
  #   if account_user.admin?
  #     [:title, :body, :tag_list]
  #   else
  #     [:tag_list]
  #   end
  # end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
