module Admin
  class Pay::PaymentMethodsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Pay::PaymentMethod.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Pay::PaymentMethod.find_by!(slug: param)
    # end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
