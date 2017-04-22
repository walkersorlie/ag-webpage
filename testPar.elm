import Html exposing (..)
import Html.Attributes exposing (..)

view model =
  div [class "paragraph" ]
  [h1 [] [ text "Header in elm"]
    , p []
      [ text "This is another way to make a paragraph of text in elm"]
  ]


main =
  view "model"
