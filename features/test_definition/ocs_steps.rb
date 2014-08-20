# -*- encoding : utf-8 -*-

#!/usr/bin/env ruby
#coding:utf-8
#encoding:utf-8


Given /^I am on the (.+)$/ do |url|
  visit "http://10.51.163.13:8080/ocs-catalog/apm_users/sign_in"
end

Given /^I am logged in "([^"]*)" system with User "([^"]*)" and password "([^"]*)" and click button "([^"]*)"$/ do |system, user, pass, button|
  visit "http://10.51.163.13:8080/ocs-catalog/apm_users/sign_in" #OCS como variavel global e fazer referencia a ela
  page.driver.browser.manage.window.maximize #maximizar a browser
  fill_in("apm_user_username", :with => user)
  fill_in("apm_user_password", :with => pass)
  click_button(button)
  page.has_selector?("Public")
  click_on("Public")
  click_on("Créditos/Débitos")
  find(:xpath, "//body[@id='apm']/ul[3]/li[3]/ul/li[8]/ul/li[2]/a/span").click
  click_on("Criar")
  fill_in("component_name", :with => "Teste_Capybara")
  fill_in("component_description", :with => "Teste automatico")
  choose("Absoluto")
  find(:xpath, "//a[contains(text(),'Bónus')]").click
  click_on("Adicionar bónus")
  click_on("Dinheiro")
  select '10', :from => 'bonus_result_values_attributes_53d2b33e84ae8be78e288111_fix_value'
  #fill_in("bonus_result_values_attributes_53d2b33e84ae8be78e288111_fix_value", :with => "10")
  click_button("Guardar")

  
end


When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  #page.check('Login')
  fill_in(field, :with => value)
end
 
When /^I press "([^"]*)"$/ do |button|
  click_button(button)
end
 
Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

When /^I search for "([^"]*)"$/ do |text|
  fill_in("search_query", :with => text)
  click_button("search-btn")
end


 
#When /^I send a "([^"]*)" "([^"]*)" on date "([^"]*)" with interface "([^"]*)"$/ do |operation, op_type, date, interface, table|
  #begin
  #  if op_type.upcase=='SESSION'
  #    type = op_type
  #  else
  #    type = op_type.match(/([^_]*)_EVENT/i)[1]
  #    assert(type.upcase!='SESSION', "Invalid charging operation type: #{op_type}")
  #  end
  #rescue NoMethodError
  #  assert(false, "Invalid charging operation type: #{op_type}")
  #end
