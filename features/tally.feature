Feature: Tally board

  Scenario: Add a death
    When I go to "/"
    Then I should see a tally count
    And I press "I got bit!"
    Then I should
