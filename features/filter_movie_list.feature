Feature: display list of movies filtered by MPAA rating

  As a concerned parent
  So that I can quickly browse movies appropriate for my family
  I want to see movies matching only certain MPAA ratings

  Background: movies have been added to database

    Given the following movies exist:
      | title                   | rating | release_date |
      | Aladdin                 | G      | 25-Nov-1992  |
      | The Terminator          | R      | 26-Oct-1984  |
      | When Harry Met Sally    | R      | 21-Jul-1989  |
      | The Help                | PG-13  | 10-Aug-2011  |
      | Chocolat                | PG-13  | 5-Jan-2001   |
      | Amelie                  | R      | 25-Apr-2001  |
      | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
      | The Incredibles         | PG     | 5-Nov-2004   |
      | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
      | Chicken Run             | G      | 21-Jun-2000  |

    And  I am on the RottenPotatoes home page

  Scenario: restrict to movies with 'PG' or 'R' ratings
    Given I check the following ratings: PG, R
    And I uncheck the following ratings: G, PG-13
    And I press "Refresh"
    Then I should see the following movies:
      | Movie Title             | Rating | Release Date            | More Info                          |
      | The Terminator          | R      | 1984-10-26 00:00:00 UTC | More about The Terminator          |
      | When Harry Met Sally    | R      | 1989-07-21 00:00:00 UTC | More about When Harry Met Sally    |
      | Amelie                  | R      | 2001-04-25 00:00:00 UTC | More about Amelie                  |
      | The Incredibles         | PG     | 2004-11-05 00:00:00 UTC | More about The Incredibles         |
      | Raiders of the Lost Ark | PG     | 1981-06-12 00:00:00 UTC | More about Raiders of the Lost Ark |

  Scenario: no ratings selected
    Given I uncheck all the ratings
    And I press "Refresh"
    Then I should see all the movies

  Scenario: all ratings selected
    Then I should see all the movies
