// config
S.cfga({
  "defaultToCurrentScreen" : true,
  "secondsBetweenRepeat" : 0.1,
  "checkDefaultsOnLoad" : true,
  "focusCheckWidthMax" : 3000,
  "windowHintsShowIcons" : true,
  "windowHintsIgnoreHiddenWindows": false,
  "windowHintsSpread": true,
  "windowHintsFontColor": [255, 0, 0, 0.8]
});

var monLap = "1366x768";
var monAsus = "1920x1080";

var fullscreen = S.op("move", { "x": "screenOriginX", "y": "screenOriginY", "width": "screenSizeX", "height": "screenSizeY" });
var lefthalf = fullscreen.dup({ "width": "screenSizeX/2" });
var righthalf = lefthalf.dup({ "x": "screenOriginX+screenSizeX/2" });
var tophalf = fullscreen.dup({ "height": "screenSizeY/2" });
var bottomhalf = tophalf.dup({ "y": "screenOriginY+screenSizeY/2" });
var topleft = S.op("corner", { "direction": "top-left", "width": "screenSizeX/2", "height": "screenSizeY/2" });
var topright = topleft.dup({ "direction": "top-right" });
var bottomleft = topleft.dup({ "direction": "bottom-left" });
var bottomright = topleft.dup({ "direction": "bottom-right" });

var appUp = function(application) {
  S.eapp(function(appObject) {
    if (appObject.name() === application) {
      appObject.eachWindow(function(winObject) {
        if (winObject.focus() === 'true') {
          return S.op("focus", { "app": +application });
        }
      });
    }
  });
  return S.op("shell", { "command": "/usr/bin/open /Applications/"+application+".app" });
};

// key binding
S.bnda({
  // resize
  "left:shift,alt": S.op("resize", { "width": "-10%", "height": "+0" }),
  "right:shift,alt": S.op("resize", { "width": "+10%", "height": "+0" }),
  "up:shift,alt": S.op("resize", { "width": "+0", "height": "-10%" }),
  "down:shift,alt": S.op("resize", { "width": "+0", "height": "+10%" }),
  // nudge
  "left:shift,cmd": S.op("nudge", { "x": "-10%", "y": "+0" }),
  "right:shift,cmd": S.op("nudge", { "x": "+10%", "y": "+0" }),
  "up:shift,cmd": S.op("nudge", { "x": "+0", "y": "-10%" }),
  "down:shift,cmd": S.op("nudge", { "x": "+0", "y": "+10%" }),
  // move
  "return:shift,alt": fullscreen,
  "h:shift,alt": lefthalf,
  "l:shift,alt": righthalf,
  "k:shift,alt": tophalf,
  "j:shift,alt": bottomhalf,
  "]:shift,alt": S.op("chain", { "operations": [ topright, bottomright, bottomleft, topleft ] }),
  "[:shift,alt": S.op("chain", { "operations": [ topright, topleft, bottomleft, bottomright ] }),
  // hint
  "space:shift,alt": S.op("hint", { "characters": "QWEASDZXC" }),
  // grid
  "g:shift,alt": S.op("grid", { "grids": { monAsus: { "width": 16, "height": 9 }}, "padding": 5 }),
  // focus
  ",:shift,alt": S.op("focus", { "direction": "left" }),
  ".:shift,alt": S.op("focus", { "direction": "right" }),
  "/:shift,alt": S.op("focus", { "direction": "below" }),
  "v:shift,alt": appUp("MacVim"),
  "i:shift,alt": appUp("iTerm"),
  "f:shift,alt": appUp("Finder"),
  "b:shift,alt": appUp("Firefox"),
  "c:shift,alt": appUp("Clearview"),
});
