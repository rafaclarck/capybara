# -*- encoding : utf-8 -*-

#encoding : utf-8
module Test_specs
require "capybara"
require "selenium-webdriver"
require "watir-webdriver"
#module Test_specs
#class Metodos

	#include Test_specs
	
	    def self.logar_ocs (user, pass, button)
		  puts "passei aqui"
		  visit "http://10.51.163.13:8080/ocs-catalog/apm_users/sign_in" #OCS como variavel global e fazer referencia a ela
		  fill_in("apm_user_username", :with => user)
		  fill_in("apm_user_password", :with => pass)
		  click_button(button)
		  #rescue LoginFailed, Watir::Wait::TimeoutError
		end
			

end
