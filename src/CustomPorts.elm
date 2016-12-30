port module CustomPorts exposing (..)

import Models exposing (..)


port incomingorientation : (Orientation -> msg) -> Sub msg


port fetchbatterystatus : String -> Cmd msg


port incomingbatterystatus : (BatteryStatus -> msg) -> Sub msg


port fetchbrowserplatforminfo : String -> Cmd msg


port incomingbrowserplatforminfo : (BrowserPlatformInfo -> msg) -> Sub msg
