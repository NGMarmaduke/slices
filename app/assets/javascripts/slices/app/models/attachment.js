// Represents an attachment object, which will contain an asset and any other
// fields the attachment is decorated with.
slices.Attachment = Backbone.Model.extend({

  // Initialize the attachment. Only thing of interest here is handling
  // the presence of files.
  initialize: function() {
    if (this.get('file')) {
      this.get('file').attachment = this;
      this.updateFileStatus();
    }
    if (this.get('asset') && this.get('asset').constructor !== slices.Asset) {
      this.set({ asset: new slices.Asset(this.get('asset')) });
    }
  },

  // Trigger normal change event when things happen with the file.
  updateFileStatus: function() {
    this.trigger('change');
  },

  toJSON: function() {
    var attrs = _.clone(this.attributes);
    attrs['crop_x']      = this.get('asset').get('crop_x')
    attrs['crop_y']      = this.get('asset').get('crop_y')
    attrs['crop_width']  = this.get('asset').get('crop_width')
    attrs['crop_height'] = this.get('asset').get('crop_height')
    return attrs;
  }

});

