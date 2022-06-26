HTMLWidgets.widget({

  name: 'video',

  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(settings) {
        let options = settings.options;
        const id = el.id;

        video = videojs(el.id, options);

        if (HTMLWidgets.shinyMode) {
          video.on("loadedmetadata", () => {
            if (settings.seek_ping_rate > 0) {
              Shiny.setInputValue(`${id}_seek`, video.currentTime());
            }
            Shiny.setInputValue(`${id}_duration`, video.duration());
            Shiny.setInputValue(`${id}_playing`, false);
          });
          video.on("play", () => {
            Shiny.setInputValue(`${id}_playing`, true);
          });
          video.on("pause", () => {
            Shiny.setInputValue(`${id}_playing`, false);
          });

          if (settings.seek_ping_rate > 0) {
            setInterval(() => {
              Shiny.setInputValue(`${id}_seek`, video.currentTime());
            }, settings.seek_ping_rate);
        }
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

  Shiny.addCustomMessageHandler("changeVideo", function(settings) {
    videojs(settings.id).src(settings.src);
  });
}
