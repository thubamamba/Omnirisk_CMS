// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { application } from "./application"

// Register each controller with Stimulus
import controllers from "./**/*_controller.js"
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})

import { Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('tabs', Tabs)
application.register('popover', Popover)
application.register('toggle', Toggle)
application.register('slideover', Slideover)

import Flatpickr from 'stimulus-flatpickr'
application.register('flatpickr', Flatpickr)

import ConditionFormElement from './conditional_form_element_controller'
application.register('condition-form-element', ConditionFormElement)

import ConditionalFormElementPropertyClaims from './conditional_form_element_property_claims_controller'
application.register('conditional-form-element-property-claims', ConditionalFormElementPropertyClaims)

import ConditionalFormElementLiability from './conditional_form_element_liability_controller'
application.register('conditional-form-element-liability', ConditionalFormElementLiability)

import ConditionalFormElementPublicLiability from './conditional_form_element_public_liability_controller'
application.register('conditional-form-element-public-liability', ConditionalFormElementPublicLiability)

import ConditionalFormElementHealthClaims from './conditional_form_element_health_claims_controller'
application.register('conditional-form-element-health-claims', ConditionalFormElementHealthClaims)

import ConditionalFormElementVehicleClaims from './conditional_form_element_vehicle_claims_controller'
application.register('conditional-form-element-vehicle-claims', ConditionalFormElementVehicleClaims)

import DarkToggle from './dark_toggle_controller'
application.register('dark-toggle', DarkToggle)

import SignaturePad from './signature_pad_controller'
application.register('signature-pad', SignaturePad)

import TextareaAutogrow from 'stimulus-textarea-autogrow'
application.register('textarea-autogrow', TextareaAutogrow)
