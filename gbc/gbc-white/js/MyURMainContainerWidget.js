/// FOURJS_START_COPYRIGHT(D,2015)
/// Property of Four Js*
/// (c) Copyright Four Js 2015, 2016. All Rights Reserved.
/// * Trademark of Four Js Development Tools Europe Ltd
///   in the United States and elsewhere
/// 
/// This file can be modified by licensees according to the
/// product manual.
/// FOURJS_END_COPYRIGHT

"use strict";

modulum('MyURMainContainerWidget', ['WidgetGroupBase', 'WidgetFactory'],
  /**
   * @param {gbc} context
   * @param {classes} cls
   */
  function(context, cls) {

    /**
     * @class classes.MyURMainContainerWidget
     * @extends classes.WidgetGroupBase
     */
    cls.MyURMainContainerWidget = context.oo.Class(cls.WidgetGroupBase, function($super) {
      /** @lends classes.MyURMainContainerWidget.prototype */
      return {
        __name: "MyURMainContainerWidget",

        constructor: function() {
          $super.constructor.call(this);

          var headerBar = new cls.MyURHeaderBarWidget();
          headerBar.setParentWidget(this);
          this.getElement().querySelector("header").appendChild(headerBar.getElement());
        }
      };
    });

    /*
     *  This is a sample widget that would replace the default one in GWC-JS
     *  To activate it, please uncomment the line below. This will override
     *  the original widget registration to this one.
     */

  //  cls.WidgetFactory.register('MainContainer', cls.MyURMainContainerWidget);
  });
