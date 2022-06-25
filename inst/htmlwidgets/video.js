HTMLWidgets.widget({

  name: 'video',

  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(settings) {
        videojs(el.id, settings);
      },

      resize: function(width, height) {
      }

    };
  }
});
