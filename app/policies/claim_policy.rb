class ClaimPolicy < ApplicationPolicy
  attr_reader :user, :claim

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
    # belongs_to_clued_account? && (account_user.admin? || account_user.member?)
    belongs_to_account_that_owns_municipality_claim? || user_owns_claims?
  end

  def belongs_to_clued_account?
    account_user.accounts.name == "Clued Tech"
  end

  def user_owns_claims?
    record.user_id == user.id
  end

  def belongs_to_account_that_owns_municipality_claim?
    # claim.municipality.account_id == account_user.account_id
    # account_user.accounts.exists?(id: claim.municipality.account_id)
    pundit_user.accounts.exists?(id: 1)
    # user_account = account_user.accounts
    # user_account.each do |account|
    #   if account.id == claim.municipality.account_id
    #     return true
    #   end
    # end
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
