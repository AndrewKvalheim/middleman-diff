Feature: Keep

  Scenario: A prompt is displayed.
  Given a fixture app "typical-modified"
  When I diff
  Then the output should contain:
    """
    Would you like to apply these changes to the build? [y/N]
    """

  Scenario: Changes are discarded by default.
  Given a fixture app "typical-modified"
  When I diff
  Then the output should contain "Preview has been discarded."
  And the file "build/index.html" should contain "original document"

  Scenario: Changes are discarded.
  Given a fixture app "typical-modified"
  When I diff and type "n"
  Then it should pass with "Preview has been discarded."
  And the file "build/index.html" should contain "original document"

  Scenario: Changes are kept.
  Given a fixture app "typical-modified"
  When I diff and type "y"
  Then it should pass with "Build has been updated."
  And the file "build/index.html" should contain "modified document"

  Scenario: Changes are always discarded.
  Given a fixture app "typical-modified"
  And the text "activate :diff" in the file "config.rb" is replaced with:
    """
    activate :diff, keep: :never
    """
  When I diff noninteractively
  Then the output should contain "Preview has been discarded."
  And the file "build/index.html" should contain "original document"

  Scenario: Changes are always kept.
  Given a fixture app "typical-modified"
  And the text "activate :diff" in the file "config.rb" is replaced with:
    """
    activate :diff, keep: :always
    """
  When I diff noninteractively
  Then the output should contain "Build has been updated."
  And the file "build/index.html" should contain "modified document"
