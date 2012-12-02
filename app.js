// Generated by CoffeeScript 1.3.3
(function() {
  var app, window;

  app = require("appjs");

  require("coffee-script");

  app.serveFilesFrom(__dirname + '/content');

  window = app.createWindow({
    width: 640,
    height: 480,
    icons: __dirname + '/content/icons'
  });

  window.on('create', function() {
    console.log('Window Created');
    window.frame.show();
    return window.frame.center();
  });

  window.on('ready', function() {
    var F12;
    this.require = require;
    this.process = process;
    this.module = module;
    console.log('Window Ready');
    F12 = function(e) {
      return e.keyIdentifier === 'F12';
    };
    return window.addEventListener('keydown', function(e) {
      if (F12(e)) {
        return window.frame.openDevTools();
      }
    });
  });

  window.on('close', function() {
    return console.log('Window Close');
  });

}).call(this);