@javascript @screenshot
Feature: Claims

  Background:
    Given I have a client
      And I'm logged in as an "ACD Manager"
      And binding.pry

  Scenario: Create a claim and be redirect to the edit page
    Given I'm on the "Create Claim" page
      And I fill out all the required fields
     When I click the "Create Claim" button
     Then I should be redirected to edit the new claim
      And see a sucessfull flash message
