module Dialog2 exposing (main)

import Html exposing (..)
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import Element exposing (..)
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
      , chickens model
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
  Represents the text area that will be updated depending on the value of the slider
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
  Creates an HTML msg of a sad chicken
-}
addSadChicken : Element.Element
addSadChicken =
    Element.image 210 210 "sadChicken.jpeg"


{-
  Adds pictures (and accompanying text) of either a happy chicken, sad chickens, or a dead planet depending on what the slider value is
-}
chickens : Model -> Html msg
chickens model =
  if (model.currentVal < 3) then
    div []
      [ Element.toHtml (Element.image 260 254 "happyChicken.png")
      , p [] [ text "Yah, you're eating no poultry! Imagine all the chickens and turkeys who are thanking you, not to mention the planet, which you are helping to save by consuming less poultry!" ]
      ]
  else if ((3 <= model.currentVal) && (model.currentVal < 12)) then
    div []
      [ Element.toHtml addSadChicken
      , p [] [ text "You're still eating poultry, but more or less the amount the average American eats, so don't think you're an outlier. You are average (but I think you can be better than average!)." ]
      ]
  else if ((12 <= model.currentVal) && (model.currentVal < 21)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadChicken, addSadChicken])
      , p [] [ text "Ooh, you are eating more poultry than the average American conumes. The chickens and turkeys aren't too pleased, and neither is the planet." ]
      ]
  else if ((21 <= model.currentVal) && (model.currentVal < 31)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadChicken, addSadChicken, addSadChicken])
      , p [] [ text "Oh man you really like you're poultry, don't you? I strongly suggest cutting back, because even though poultry is generally healthier than red meat, vegetables are still much better, especially for the planet." ]
      ]
  else if ((31 <= model.currentVal) && (model.currentVal < 41)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadChicken, addSadChicken, addSadChicken, addSadChicken])
      , p [] [ text "Wow, you are eating about 4x as much poultry as the average American. The planet is really suffering. Turn back now!" ]
      ]
  else
    div []
      [ Element.toHtml (Element.image 250 250 "deadEarth.jpg")
      , p [] [ text "Good thing we all don't eat as much as you. You are eating 5x the amount of poultry as the average American. If every American ate this much poultry, there wouldn't be enough space on Earth to sustain us. Reconsider your choices." ]
      ]


main =
  Html.beginnerProgram
    { model = { currentVal = 9 }
    , view = view
    , update = update
    }
