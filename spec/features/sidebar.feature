@javascript @screenshot
Feature: Sidebar

  Background:
    Given I'm logged in

  Scenario: "Create Claim" should be the current link when clicked
    Given I click on "Create Claim"
    Then It should be selected
