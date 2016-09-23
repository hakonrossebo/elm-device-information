module Subscriptions exposing (..)

import Models exposing (..)
import Messages exposing (..)
import CustomPorts exposing (..)
import Time
import Window

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
      [ incomingorientation OrientationMessage
      , incomingbatterystatus BatteryMessage
      , incomingbrowserplatforminfo BrowserPlatformInfoMessage
      , Window.resizes (\{width, height} -> Resize width height)
      ]
