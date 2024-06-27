module Admin
  class DashboardController < Admin::ApplicationController
    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
    def show
      @total_claims = total_claims
      @total_new_claims = total_new_claims
      @total_municipalities = total_municipalities
      @total_revenue = total_revenue
      @last_12_mos = last_12_mos
      @last_month = last_month
      @this_month = this_month
      @users = ::User.all.count
      @subscriptions = ::Pay::Subscription.active.count
    end

    def total_claims
      ::Claim.count
    end

    def total_new_claims
      ::Claim.where(status: 'Incoming').count
    end

    def total_municipalities
      ::Municipality.count
    end

    def total_revenue
      revenue_in_cents = ::Pay::Charge.sum(:amount)
      refunds_in_cents = ::Pay::Charge.sum(:amount_refunded)
      (revenue_in_cents - refunds_in_cents) / 100.0
    end

    def last_12_mos
      revenue_for_range 12.months.ago..Time.current
    end

    def last_month
      revenue_for_range Time.current.prev_month.all_month
    end

    def this_month
      revenue_for_range Time.current.all_month
    end

    def revenue_for_range(range)
      revenue_in_cents = ::Pay::Charge.where(created_at: range).sum(:amount)
      refunds_in_cents = ::Pay::Charge.where(created_at: range).sum(:amount_refunded)
      (revenue_in_cents - refunds_in_cents) / 100.0
    end
  end
end
