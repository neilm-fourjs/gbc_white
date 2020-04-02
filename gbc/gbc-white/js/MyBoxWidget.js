/// FOURJS_START_COPYRIGHT(D,2015)
/// Property of Four Js*
/// (c) Copyright Four Js 2015, 2019. All Rights Reserved.
/// * Trademark of Four Js Development Tools Europe Ltd
///   in the United States and elsewhere
/// 
/// This file can be modified by licensees according to the
/// product manual.
/// FOURJS_END_COPYRIGHT

"use strict";

modulum('MyBoxWidget', ['BoxWidget', 'WidgetFactory'],
  function(context, cls) {

    /**
     * MyBox widget
     * @publicdoc Widgets
     * @class MyBoxWidget
     * @memberOf classes
     * @extends classes.BoxWidget
     */
    cls.MyBoxWidget = context.oo.Class(cls.BoxWidget, function($super) {
      return /** @lends classes.BoxWidget.prototype */ {
        __name: "MyBoxWidget",
        /**
         * @inheritDoc
         */
        constructor: function(opts) {
          $super.constructor.call(this, opts);
          this._element.addClass("g_MyBoxLayoutEngine");
        },
        /**
         * @inheritDoc
         */
        _initLayout: function() {
          this._layoutInformation = new cls.LayoutInformation(this);
          this._layoutEngine = new cls.MyBoxLayoutEngine(this);
          var rawMeasure = this._layoutInformation.getRawMeasure();
          rawMeasure.setHeight("300px");
        },
        /**
         * @inheritDoc
         */
        _createSplitter: function() {
          return cls.WidgetFactory.createWidget("VBoxSplitter", this.getBuildParameters());
        },
        /**
         * Get the Data area height
         * @returns {number} scroll data area height
         */
        getDataAreaHeight: function() {
          return this.getContainerElement().getBoundingClientRect().height;
        },
        /**
         * Get the Data area width
         * @returns {number} scroll data area width
         */
        getDataAreaWidth: function() {
          return this.getContainerElement().getBoundingClientRect().width;
        },
        /**
         * @inheritDoc
         */
        addChildWidget: function(widget, options) {
          options = options || {
            position: 0
          };
          $super.addChildWidget.call(this, widget, options);
        },
      };
    });
    cls.WidgetFactory.register('VBox','tiled', cls.MyBoxWidget);
    cls.WidgetFactory.register('HBox[customWidget=vbox]','tiled', cls.MyBoxWidget);
  });
