module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Svg as SVG
import Svg.Attributes as SvgAttr

import Material.Scheme
import Models exposing (..)
import Messages exposing (..)
import Utils exposing (..)

view : Model -> Html Msg
view model =
  let
    body =
        div
          [ style [ ("padding", "1rem") ] ]
          [ viewOrientation model
          , viewLocation model
          , viewBatteryStatus model
          , viewBrowserPlatformInfo model
          ]
  in
    body
    |> Material.Scheme.top


viewOrientation : Model -> Html Msg
viewOrientation model =
  div []
  [
     h4 [][text "Device orientation"]
    , viewOrientationGfx model
    , h6 [][text <| "Rough estimate of orientation: " ++ (estimateDeviceOrientationText model.currentOrientation)]
    , div [][text <| "(Alpha) - compass: " ++ (toString <| roundTo 2 <| model.currentOrientation.alpha) ]
    , div [][text <| "(Beta) - tilt - front/back: " ++ (toString <| roundTo 2 <| model.currentOrientation.beta )]
    , div [][text <| "(Gamma) - tilt - right/left: " ++ (toString <| roundTo 2 <| model.currentOrientation.gamma )]
  ]


viewOrientationGfx : Model -> Html Msg
viewOrientationGfx model =
  let
    angle =
      (model.currentOrientation.alpha - 90) * pi / 180

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)

    gammaXpos = toString (model.currentOrientation.gamma / 90 * 100 + 50)
    betaXpos = toString (model.currentOrientation.beta / 180 * 100 + 50)
  in
    SVG.svg [ SvgAttr.viewBox "0 0 100 100", SvgAttr.width "200px" ]
      [ SVG.rect [ SvgAttr.x "0", SvgAttr.y "0", SvgAttr.width "100", SvgAttr.height "100", SvgAttr.fill "#0B79CE" ] []
      , SVG.line [ SvgAttr.x1 "0", SvgAttr.y1 "50", SvgAttr.x2 "100", SvgAttr.y2 "50", SvgAttr.stroke "#000000" ] []
      , SVG.line [ SvgAttr.x1 "50", SvgAttr.y1 "0", SvgAttr.x2 "50", SvgAttr.y2 "100", SvgAttr.stroke "#000000" ] []
      , SVG.line [ SvgAttr.x1 "0", SvgAttr.y1 betaXpos, SvgAttr.x2 "100", SvgAttr.y2 betaXpos, SvgAttr.strokeDasharray "2, 5", SvgAttr.strokeWidth "3", SvgAttr.stroke "#AAAAAA" ] []
      , SVG.line [ SvgAttr.x1 gammaXpos, SvgAttr.y1 "0", SvgAttr.x2 gammaXpos, SvgAttr.y2 "100", SvgAttr.strokeDasharray "2, 5", SvgAttr.strokeWidth "3", SvgAttr.stroke "#AAAAAA" ] []
      , SVG.line [ SvgAttr.x1 "50", SvgAttr.y1 "50", SvgAttr.x2 handX, SvgAttr.y2 handY, SvgAttr.stroke "#CCCCCC" ] []
      ]


viewLocation : Model -> Html Msg
viewLocation model =
  let
    locationText =
      case model.location of
        Nothing ->
          "GPS location not found"
        Just loc ->
          let
            (latitude, longitude, altitude, altitudeAccuracy) = getLocationInfo (Just loc)
          in
            (toString latitude) ++ ", " ++ (toString longitude)
  in
    div []
    [ h4 [][text "GPS location"]
    , h6[][text locationText]
    ]


viewBatteryStatus : Model -> Html Msg
viewBatteryStatus model =
  let
    batteryLevel =
      case model.currentBatteryStatus of
        Nothing ->
          "No battery information"
        Just status ->
          toString (status.level * 100) ++ "%"
  in
    div []
    [ h4 [][text "Battery status"]
    , h6[][text batteryLevel]
    ]


viewBrowserPlatformInfo : Model -> Html Msg
viewBrowserPlatformInfo model =
  let
    (browserText, platformText) =
      case model.browserPlatformInfo of
        Nothing ->
          ("Browser not detected", "Platform not detected")
        Just info ->
          (info.browser, info.platform)
  in
    div []
    [ h4 [][text "Browser and platform"]
    , h6[][text (platformText ++ ", " ++ browserText) ]
    ]
