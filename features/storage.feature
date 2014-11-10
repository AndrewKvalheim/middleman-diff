Feature: Storage

  Scenario: The temporary directory is created if necessary.
  Given a fixture app "typical"
  When I diff
  Then a directory named "tmp" should exist

  Scenario: The preview directory is cleaned when unused.
  Given a fixture app "typical" without "build"
  When I attempt to diff
  Then a directory named "tmp" should be empty

  Scenario: The preview directory is cleaned.
  Given a fixture app "typical"
  When I diff
  Then a directory named "tmp" should be empty

  Scenario: A non-default temporary directory is configured and created.
  Given a fixture app "typical"
  And the text "activate :diff" in the file "config.rb" is replaced with:
    """
    activate :diff, temp_dir: 'some/other/location'
    """
  When I diff
  Then a directory named "some/other/location" should exist
