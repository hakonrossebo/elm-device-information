module Updates exposing (..)


import Material
import Models exposing (..)
import Messages exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      ( model
      , Cmd.none
      )

    Resize w h ->
      ( { model | height = h, width = w }, Cmd.none )

    NewDate newDate->
      ( {model | currentDate = Just newDate}
      , Cmd.none
      )

    -- Boilerplate: Mdl action handler.
    Mdl msg' ->
      Material.update msg' model

    OrientationMessage orientation ->
      let
        -- smoothedOrientation = smoothOrientation orientation model.currentOrientation
        smoothedOrientation = orientation
        newOrientation = {alpha = smoothedOrientation.alpha, beta = smoothedOrientation.beta, gamma = smoothedOrientation.gamma}
      in
        ({model | currentOrientation = newOrientation} ,Cmd.none)

    BatteryMessage batteryStatus ->
      ({model | currentBatteryStatus = Just batteryStatus}, Cmd.none)

    BrowserPlatformInfoMessage browserPlatformInfo ->
      ({model | browserPlatformInfo = Just browserPlatformInfo}, Cmd.none)

    LocationReceived location ->
      ({model | location = Just location}, Cmd.none)




smoothOrientation : Orientation -> Orientation -> Orientation
smoothOrientation newOrientation existingOrientation =
  let
    alphaDiff = abs (existingOrientation.alpha - newOrientation.alpha)
    betaDiff = abs (existingOrientation.beta - newOrientation.beta)
    gammaDiff = abs (existingOrientation.gamma - newOrientation.gamma)
    newAlpha = if alphaDiff > 20 then newOrientation.alpha else existingOrientation.alpha
    newBeta = if betaDiff > 20 then newOrientation.beta else existingOrientation.beta
    newGamma = if gammaDiff > 20 then newOrientation.gamma else existingOrientation.gamma
  in
    {alpha = newAlpha, beta = newBeta, gamma = newGamma}