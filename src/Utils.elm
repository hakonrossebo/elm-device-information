module Utils exposing (..)

import Date
import Date.Format
import Geolocation
import Models exposing (..)


getDateString : Maybe Date.Date -> String
getDateString date =
    case date of
        Nothing ->
            "2016-09-01T00:00:00Z"

        Just date ->
            Date.Format.formatISO8601 date


getLocationInfo : Maybe Geolocation.Location -> ( Float, Float, Float, Float )
getLocationInfo location =
    case location of
        Just loc ->
            let
                altitude =
                    Maybe.withDefault { value = 0, accuracy = 0 } loc.altitude

                lat =
                    roundTo 2 <|
                        if (abs loc.latitude > 90) then
                            0
                        else
                            loc.latitude

                lon =
                    roundTo 2 <|
                        if (abs loc.longitude > 180) then
                            0
                        else
                            loc.longitude

                alt =
                    roundTo 2 <|
                        if (altitude.value > 10000) then
                            0
                        else
                            altitude.value

                altAccuracy =
                    roundTo 2 <|
                        if (altitude.accuracy > 1000) then
                            0
                        else
                            altitude.accuracy
            in
                ( lat, lon, alt, altAccuracy )

        Nothing ->
            ( 0, 0, 0, 0 )


estimateDeviceOrientationText : Orientation -> String
estimateDeviceOrientationText orientation =
    if (abs orientation.beta < 15 && abs orientation.gamma < 15) then
        "Horizontal (lying on table)"
    else if (abs orientation.beta >= 15 && abs orientation.beta < 90 && abs orientation.gamma < 15) then
        "Holding in hand, portrait"
    else if (abs orientation.beta < 15 && abs orientation.gamma >= 15 && abs orientation.gamma < 90) then
        "Holding in hand, landscape"
    else if (abs orientation.beta >= 90 && abs orientation.gamma >= 90) then
        "Vertical"
    else
        "Up/down"


{-| Round a `Float` to a given number of decimal places. (From krisajenkins/elm-exts)
-}
roundTo : Int -> Float -> Float
roundTo places value =
    let
        factor =
            toFloat (10 ^ places)
    in
        ((value
            * factor)
            |> round
            |> toFloat
        )
            / factor
