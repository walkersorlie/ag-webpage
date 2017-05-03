module Dairy exposing (main)

import IntroDialog exposing (view)
import Html exposing (..)
import Html.Attributes as HAtt exposing (..)
import Html.Events exposing (on, onInput)
import Element exposing (..)
import Text exposing (fromString)
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
      { model | currentVal = String.toInt v |> Result.withDefault 0 } 


{-
  Calculates the minimum value of the slider
-}
sliderMin : Attribute msg
sliderMin =
  HAtt.max "0"


{-
  Calculates the maximum value of the slider
-}
sliderMax : Attribute msg
sliderMax =
  HAtt.max "50"


myStyle : Attribute msg
myStyle =
  style
    [ ("backgroundColor", "red")
    , ("height", "90px")
    , ("width", "100%")
    ]


{-
  Represents the slider and the paragraph of text describing the data according to the slider
-}
view : Model -> Html Msg
view model =
  div []
    [ hr [] []
    , bodyUpdate model
    , div []
      [ input
        [ type_ "range"
        , sliderMin
        , sliderMax
        , value <| toString model.currentVal
        , onInput ChangeSlider
        ] []
        ,  text <| toString model.currentVal
      ]
      , cows model
      , hr [] []
      , followingText model
    ]


calcVal : Int -> Html msg
calcVal sliderVal =
  div []
    [ makePar ("The average American consumes about 209 lb of dairy a year, or on average 17 lb a month. For dairy, if you consume " ++ toString sliderVal ++ " pound(s) a month, your yearly dairy C02e emissions would be " ++ toString (calcDairy sliderVal) ++ " lbs C02e, or approximately " ++ toString (calcTons sliderVal) ++ " tons of C02e per year.")
    , sup [] [ text "(The total emissions includes production emissions and post-production emissions.)" ]
    ]


{-
  Calculates the total emissions from dairy (cheese, yogurt, and milk)
  Returns the anser in pounds
-}
calcDairy: Int -> Int
calcDairy pounds =
  round ((calcCheese (calcKilos (pounds)) + (calcYogurt (calcKilos pounds)) + (calcMilk (calcKilos pounds))) * 2.20462)


{-
  Calculates the emissions from cheese
  Returns the answer in kilograms
-}
calcCheese : Float -> Float
calcCheese kilos =
  (kilos / 30.44) * 4036 * 365 * (13.5 / 4036)


{-
  Calculates the emissions from yogurt
  Returns the answer in kilograms
-}
calcYogurt : Float -> Float
calcYogurt kilos=
  (kilos / 30.44) * 588 * 365 * (2.2 / 588)


{-
  Calculates the emissions from milk
  Returns the answer in kilograms
-}
calcMilk : Float -> Float
calcMilk kilos =
  (kilos / 30.44) * 422 * 365 * (1.9 / 422)


{-
  Converts pounds to kilograms
-}
calcKilos : Int -> Float
calcKilos poundToKilo  =
  (toFloat poundToKilo / 0.453592)


{-
  Converts pounds to tons
  Rounds to the nearest whole number
-}
calcTons : Int -> Int
calcTons tons =
  round ((toFloat (calcDairy tons)) * 0.0005)

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
  Creates an HTML msg of a sad cow
-}
addSadCow : Element.Element
addSadCow =
    Element.image 125 193 "sadCow.jpg"


{-
  Adds pictures (and accompanying text) of either a happy cow, sad cows, or a dead planet depending on what the slider value is
-}
cows : Model -> Html msg
cows model =
  if (model.currentVal < 4) then
    div []
      [ Element.toHtml (Element.flow Element.right [ Element.image 270 270 "happyCow.jpeg", Element.image 270 270 "happyCow.jpeg" ])
      , p [] [ text "Yah, you're consuming almost no dairy! Imagine all the cows who are thanking you, not to mention the planet, which you are helping to save by consuming less meat!" ]
      ]
  else if ((4 <= model.currentVal) && (model.currentVal < 10)) then
    div []
      [ Element.toHtml (Element.image 270 270 "happyCow.jpeg")
      , p [] [ text "Congrats, you're consuming much less dairy than the average American! Keep up the good work, and continue reducing your dairy consumption!" ]
      ]

  else if ((10 <= model.currentVal) && (model.currentVal < 20)) then
    div []
      [ Element.toHtml addSadCow
      , p [] [ text "You're still eating meat, but more or less the amount the average American eats, so don't think you're an outlier. You are average (but I think you can be better than average!)." ]
      ]
  else if ((12 <= model.currentVal) && (model.currentVal < 21)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadCow, addSadCow])
     , p [] [ text "Ooh, you are eating more meat than the average American conumes. The cows aren't too pleased, and neither is the planet." ]
      ]
  else if ((21 <= model.currentVal) && (model.currentVal < 31)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadCow, addSadCow, addSadCow])
      , p [] [ text "Oh man you really like you're meat, don't you? I strongly suggest cutting back, not only for the sake of the planet, but for the sake of your health. Red meat isn't all that good for you." ]
      ]
  else if ((31 <= model.currentVal) && (model.currentVal < 41)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadCow, addSadCow, addSadCow, addSadCow])
      , p [] [ text "Wow, you are eating about 4x as much meat as the average American. The planet and your health are really suffering. Turn back now!" ]
      ]
  else
    div []
      [ Element.toHtml (Element.image 250 250 "deadEarth.jpg")
      , p [] [ text "Good thing we all don't eat as much as you. You are eating 5x the amount of meat as the average American. If every American ate this much meat, there wouldn't be enough space on Earth to sustain us. Reconsider your choices." ]
      ]


followingText : Model -> Html msg
followingText model =
  div []
    [ makePar ("Ok, so now that we looked at dairy and you saw that if you consume " ++ toString model.currentVal ++ " pounds of dairy a month, you create " ++ toString (calcTons model.currentVal) ++ " tons of C02 equivalents a year. Now, lets look at poultry to see what kind of impact your poultry consumption has on the environment.")
    ]


{-
  Runs Dairy.elm, with the slider starting at the value '9'
-}
main =
  Html.beginnerProgram
    { model = { currentVal = 17 }
    , view = view
    , update = update
    }
