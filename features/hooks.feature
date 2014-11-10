Feature: Hooks

  Scenario: Build hooks are not modified.
  Given a fixture app "typical"
  When I successfully run `middleman build`
  Then the output should contain "The before_build hook has been run."
  And the output should contain "The after_build hook has been run."

  Scenario: Build hooks are run.
  Given a fixture app "typical"
  When I diff
  Then the output should contain "The before_build hook has been run."
  And the output should contain "The after_build hook has been run."

  Scenario: Build hooks have been disabled.
  Given a fixture app "typical"
  And the text "activate :diff" in the file "config.rb" is replaced with:
    """
    activate :diff, build_hooks: false
    """
  When I diff and type "n"
  Then the output should not match /The \w+_build hook has been run./

  Scenario: Files from a build hook are previewed.
  Given a fixture app "typical"
  And I append to "config.rb" with "activate :gzip"
  When I diff
  Then a file named "build/index.html.gz" should not exist

  Scenario: Files from a build hook are kept.
  Given a fixture app "typical"
  And I append to "config.rb" with "activate :gzip"
  When I diff and type "y"
  Then a file named "build/index.html.gz" should exist
