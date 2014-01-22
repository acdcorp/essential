@javascript @screenshot
Feature: Authentication

  Scenario Outline: redirect each user to /claims on sucessfull login
    Given I login as <role>
    Then I should be at /claims

    Scenarios:
      | role           |
      | dev            |
      | admin          |
      | acd_staff      |
      | acd_manager    |
      | client_staff   |
      | client_manager |

  Scenario: when not logged in, redirect to /login if you visit /claims
    Given I visit /claims
    Then I should be at the /login page
