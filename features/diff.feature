Feature: Diff

  Scenario: There is no last build.
  Given a fixture app "typical" without "build"
  When I attempt to diff
  Then it should fail with "There's no existing build to compare against."

  Scenario: No changes have been made since the last build.
  Given a fixture app "typical"
  When I diff
  Then the output should not match /^[+-]/

  Scenario: A file has been created since the last build.
  Given a fixture app "typical"
  And a file named "source/created.html.haml" with:
    """
    This is the created document.
    """
  When I diff
  Then the output should match /^\+\s+This is the created document/
  And the output should not match /^-\s+/

  Scenario: A file has been modified since the last build.
  Given a fixture app "typical"
  And a file named "source/index.html.haml" with:
    """
    This is the modified document.
    """
  When I diff
  Then the output should match /^-\s+This is the original document/
  And the output should match /^\+\s+This is the modified document/

  Scenario: A file has been deleted since the last build.
  Given a fixture app "typical"
  And I remove the file "source/index.html.haml"
  When I diff
  Then the output should match /^-\s+This is the original document/
  And the output should not match /^\+\s+/
