# -*- encoding : utf-8 -*-
require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "IdeRuby" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://10.51.163.13:8080/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_ide_ruby" do
    @driver.get(@base_url + "/ocs-catalog/apm_users/sign_in")
    @driver.find_element(:id, "apm_user_username").click
    @driver.find_element(:id, "apm_user_username").clear
    @driver.find_element(:id, "apm_user_username").send_keys "apm"
    @driver.find_element(:id, "apm_user_password").clear
    @driver.find_element(:id, "apm_user_password").send_keys "apmapm"
    @driver.find_element(:css, "button[type=\"submit\"]").click
    !60.times{ break if (element_present?(:link, "Public") rescue false); sleep 1 }
    @driver.find_element(:link, "Public").click
    !60.times{ break if (element_present?(:css, "span.desc") rescue false); sleep 1 }
    @driver.find_element(:link, "Processos").click
    !60.times{ break if (element_present?(:xpath, "//body[@id='apm']/ul[3]/li[3]/ul/li[2]/ul/li[2]/a/span") rescue false); sleep 1 }
    @driver.find_element(:xpath, "//body[@id='apm']/ul[3]/li[3]/ul/li[2]/ul/li[2]/a/span").click
    @driver.find_element(:css, "div.q-actions > a > span.desc").click
    @driver.find_element(:id, "component_name").clear
    @driver.find_element(:id, "component_name").send_keys "testado_selenium"
    @driver.find_element(:id, "spending_limit_type_absolute").click
    @driver.find_element(:id, "spending_limit_absolute_unit_unit_monetary").click
    @driver.find_element(:id, "spending_limit_value").clear
    @driver.find_element(:id, "spending_limit_value").send_keys "10"
    @driver.find_element(:id, "save_component_link").click
    @driver.find_element(:link, "Servicos e Saldos").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
