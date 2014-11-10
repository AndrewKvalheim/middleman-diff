Feature: Extension

  Scenario: Activation is required.
  Given a fixture app "inactive"
  When I attempt to diff
  Then it should fail with "You must activate this extension."

  Scenario: The build command is unaffected.
  Given a fixture app "typical"
  When I successfully run `middleman build`
  Then a directory named "build" should exist
