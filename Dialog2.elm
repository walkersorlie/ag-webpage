module Dialog2 exposing (main)

import Html exposing (..)
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import String


{-
  The type of message the 'view' is expecting
-}
type Msg =
  ChangeSlider String


{-
  This model represents the body text and the number
  that will influence how the results are displayed
-}
type alias Model  =
  { currentVal : Int
  }


{-
  Set what the first view of what the model looks like
-}
initialModel : Model
initialModel =
  { currentVal = 0 }


{-
  This is the update function that updates the slider.
  The value of the slider is used to update the carbon footprint of the user
-}
update : Msg -> Model -> Model
update num model =
  case num of
    ChangeSlider v ->
      { model | currentVal = String.toInt v |> Result.withDefault 0 } -- currentVal is the number of the slider


{-
  Represents the slider and the paragraph of text.

  Have IntroDialog, then a slider, then some text that wont change,
  then another Dialog, then a slider, etc.
-}
view : Model -> Html Msg
view model =
  div []
    [ hr [] []
    , bodyUpdate model    -- displays the text before the slider
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

{-
  White meat: consumption (kCal/day)*365*EF (kg CO2e/kCal) = emissions (kg CO2e/yr)

  Include info about how it's hard to get an exact number
  Combined turkey with chicken meat
-}
calcVal : Int -> Html msg
calcVal sliderVal =
  div []
    [ makePar ("For white meat, if you eat " ++ toString sliderVal ++ " pound(s) a month, your yearly white meat C02e emissions would be " ++ toString (calcWhiteMeatEmiss sliderVal) ++ " lbs C02e, or approximately " ++ toString (calcTons sliderVal) ++ " tons C02e per year.")
    , sub [] [ text "(The total emissions includes production emissions and post-production emissions.)" ]
    ]


{-
  Converts pounds to kilograms
  Rounds to the nearest whole number
-}
calcKilos : Int -> Float
calcKilos poundToKilo  =
  (toFloat poundToKilo / 0.453592)


{-
  Calculates the carbon emission of white meat
-}
calcWhiteMeatEmiss : Int -> Int
calcWhiteMeatEmiss poundOfWhiteMeat =
  round (((calcKilos poundOfWhiteMeat / 30.44) * 1716.5 * 365 * (17.8/1716.5)) * 2.20462)


{-
  Converts pounds to tons
  Rounds to the nearest whole number
-}
calcTons : Int -> Int
calcTons tons =
  round ((toFloat (calcWhiteMeatEmiss tons)) * 0.0005)


{-
  Creates a paragraph HTML header to pass to bodyUpdate
-}
makePar : String -> Html msg
makePar words =
  p [] [ text words ]


{-
  Represents the text area that will be updated.
  Attempt to update the body text with the new model.
  Have something similar down below, just trying something else here
-}
bodyUpdate : Model -> Html msg
bodyUpdate model =
  let val =
    calcVal model.currentVal
  in
    div []
      [ val
      ]


{-
  Don't think I use this

bodyText : Model -> Html msg
bodyText model =
  let val =
    calcVal model.currentVal
  in
    div []
      [ p [] [ text "Changed text here. Equations to come." ]
      ]
-}

main =
  Html.beginnerProgram
    { model = { currentVal = 0 }
    , view = view
    , update = update
    }
