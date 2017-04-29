module Dialog exposing (main)

import IntroDialog exposing (view)
import Html exposing (..)
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import String


type Msg =
  ChangeSlider String


{-- This model represents the body text and the number
  that will influence how the results are displayed
-}
type alias Model  =
  { currentVal : Int
  }


-- Set what the first view of what the model looks like. The current number to apply to the math functions
initialModel : Model
initialModel =
  { currentVal = 0 }


-- Changes the number that is passed to the body to update the carbon footprint of the user
update : Msg -> Model -> Model
update num model =
  case num of
    ChangeSlider v ->
      { model | currentVal = String.toInt v |> Result.withDefault 0 } -- currentVal is the number of the slider


{- Represents the slider and the paragraph of text.

  Have IntroDialog, then a slider, then some text that wont change,
  then another Dialog, then a slider, etc.
-}
view : Model -> Html Msg
view model =
  div []
    [ IntroDialog.view
    , hr [] []
    , bodyUpdate model -- bodyText    -- displays the text before the slider
    , div []
      [ input
        [ type_ "range"
        , H.min "0"
        , H.max "50"
        , value <| toString model.currentVal
        , onInput ChangeSlider
        ] []
        ,  text <| toString model.currentVal
      ]
    ]


-- This will take the model and modify it with my equations
calcVal : Int -> Html msg
calcVal sliderVal =
  makePar ("This is the text here. This number: " ++ toString (5 + sliderVal) ++ " changes with the slider.")


makePar : String -> Html msg
makePar words =
  p [] [ text words ]

{- Represents the text area that will be updated.
 Attempt to update the body text with the new model.
  Have something similar down below, just trying something else here
-}
bodyUpdate : Model -> Html msg
bodyUpdate model =
  let val =
    calcVal model.currentVal
  in
    div []
      [ val  -- text "Changed text here. Equations to come. This number " ++ (val) ++ " changes." ]
      ]

bodyText : Model -> Html msg
bodyText model =
  let val =
    calcVal model.currentVal
  in
    div []
      [ p [] [ text "Changed text here. Equations to come." ]
      ]


main =
  Html.beginnerProgram
    { model = { currentVal = 0 }
    , view = view
    , update = update
    }
