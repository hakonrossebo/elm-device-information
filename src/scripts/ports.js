var myOrientationApp = Elm.Main.fullscreen();

myOrientationApp.ports.fetchbatterystatus.subscribe(function(word) {
    if (typeof navigator.getBattery === "undefined")
        {
            return;
        }
    navigator.getBattery().then(function(battery) {
        var myDischargingTime = 99999;
        if (battery.dischargingTime != Infinity)
            myDischargingTime = battery.dischargingTime;
        var customBattery = {charging: battery.charging, dischargingTime: battery.dischargingTime, level: battery.level}
        myOrientationApp.ports.incomingbatterystatus.send(customBattery)
    });
});

myOrientationApp.ports.fetchbrowserplatforminfo.subscribe(function(word) {
    var navigatorObject = window.navigator;
    var sBrowser, sUsrAg = navigatorObject.userAgent;
    if(sUsrAg.indexOf("Chrome") > -1) {
        sBrowser = "Google Chrome";
    } else if (sUsrAg.indexOf("Safari") > -1) {
        sBrowser = "Apple Safari";
    } else if (sUsrAg.indexOf("Opera") > -1) {
        sBrowser = "Opera";
    } else if (sUsrAg.indexOf("Firefox") > -1) {
        sBrowser = "Mozilla Firefox";
    } else if (sUsrAg.indexOf("MSIE") > -1) {
        sBrowser = "Microsoft Internet Explorer";
    } else sBrowser = "Browser not detected"

    var cpu = (navigatorObject.oscpu !== undefined) ? navigatorObject.oscpu : "No cpu detected";
    var customBrowserPlatformInfo = {
        userAgent : navigatorObject.userAgent
        , browser : sBrowser
        , platform : navigatorObject.platform
        , oscpu : cpu
        , appName : navigatorObject.appName
        , appVersion : navigatorObject.appVersion
        , appCodeName : navigatorObject.appCodeName
        }
    console.log (customBrowserPlatformInfo);
    myOrientationApp.ports.incomingbrowserplatforminfo.send(customBrowserPlatformInfo)
});


function deviceOrientationListener(event) {
    var alpha = event.alpha == null ? 0 : event.alpha;
    var beta = event.beta == null ? 0 : event.beta;
    var gamma = event.gamma == null ? 0 : event.gamma;
    
        var customEvent = {alpha: alpha, beta: beta, gamma: gamma}
        myOrientationApp.ports.incomingorientation.send(customEvent);
}

if (window.DeviceOrientationEvent) {
    window.addEventListener("deviceorientation", deviceOrientationListener);
}
else {
        alert("Sorry, your browser doesn't support Device Orientation");
}
