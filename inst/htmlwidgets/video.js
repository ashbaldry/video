HTMLWidgets.widget({

  name: 'video',

  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(settings) {
        videojs(el.id, settings);

        if (settings.seek_ping_rate > 0 && HTMLWidgets.shinyMode) {
          setInterval(() => {
            Shiny.setInputValue(`${el.id}_seek`, videojs(el.id).currentTime());
          }, settings.seek_ping_rate);
        }
      },

      resize: function(width, height) {
      }
    };
  }
});

if (HTMLWidgets.shinyMode) {
  Shiny.addCustomMessageHandler("playVideo", function(id) {
    videojs(id).play();
  });

  Shiny.addCustomMessageHandler("pauseVideo", function(id) {
    videojs(id).pause();
  });

  Shiny.addCustomMessageHandler("stopVideo", function(id) {
    videojs(id).pause();
    videojs(id).currentTime(0);
  });

  Shiny.addCustomMessageHandler("seekVideo", function(settings) {
    videojs(settings.id).currentTime(settings.seek);
  });
}
