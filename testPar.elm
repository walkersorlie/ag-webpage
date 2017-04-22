import Html exposing (..)
import Html.Attributes exposing (..)

{- This is a basic example of a paragraph in Elm.
  I haven't decided on the exact layout I want, i.e.
  how much native html I will use for paragraphs vs
  how much I will use Elm. I will decide later when I
  start implementing my slider functionality
  -}
view model =
  div [class "paragraph" ]
  [h1 [] [ text "Header in elm"]
    , p []
      [ text "This is another way to make a paragraph of text in elm" ]
  ]


main =
  view "model"
