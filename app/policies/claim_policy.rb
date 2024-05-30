class ClaimPolicy < ApplicationPolicy
  # https://github.com/varvet/pundit
  # See ApplicationPolicy for defaults

  def index?
    belongs_to_account_that_owns_municipality_claim? && (account_user.admin? || account_user.member?)
  end

  # def show?
  #   account_user.admin? || account_user.member?
  # end

  # def create?
  #   account_user.admin? || account_user.member?
  # end

  # The only users who can update a claim are those who belong to the Entresure account
  def update?
    belongs_to_clued_account? && (account_user.admin? || account_user.member?)
  end

  def belongs_to_clued_account?
    account_user.accounts.name == "Clued Tech"
  end

  def belongs_to_account_that_owns_municipality_claim?
    claim.municipality.account_id == account_user.account_id
  end

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
