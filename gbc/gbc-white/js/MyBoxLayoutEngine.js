/// FOURJS_START_COPYRIGHT(D,2014)
/// Property of Four Js*
/// (c) Copyright Four Js 2014, 2019. All Rights Reserved.
/// * Trademark of Four Js Development Tools Europe Ltd
///   in the United States and elsewhere
/// 
/// This file can be modified by licensees according to the
/// product manual.
/// FOURJS_END_COPYRIGHT

"use strict";

modulum('MyBoxLayoutEngine', ['DBoxLayoutEngine'],
  function(context, cls) {
    /**
     * @class MyBoxLayoutEngine
     * @memberOf classes
     * @extends classes.DBoxLayoutEngine
     */
    cls.MyBoxLayoutEngine = context.oo.Class(cls.DBoxLayoutEngine, function() {
      return /** @lends classes.MyBoxLayoutEngine.prototype */ {
        __name: "MyBoxLayoutEngine",
        _mainSizeGetter: "getHeight",
        _mainSizeSetter: "setHeight",
        _mainHasSizeGetter: "hasHeight",
        _mainStretch: "Y",
        _oppositeSizeGetter: "getWidth",
        _oppositeSizeSetter: "setWidth",
        _oppositeHasSizeGetter: "hasWidth",
        _oppositeStretch: "X",

        /**
         * @inheritDoc
         */
        _setItemClass: function(position, start, size) {
          this._styleRules[".g_measured .gbc_MyBoxWidget" + this._widget._getCssSelector() +
            ">div>.containerElement>.g_BoxElement:nth-of-type(" + ( position + 1) + ")"] = {
            top: cls.Size.cachedPxImportant(start),
            height: cls.Size.cachedPxImportant(size)
          };
        },

        /**
         * @inheritDoc
         */
        _setItemOppositeClass: function(position) {
          this._styleRules[".g_measured .gbc_MyBoxWidget" + this._widget._getCssSelector() +
            ">div>.containerElement>.g_BoxElement:nth-of-type(" + (
              position + 1) +
            ")"].width = cls.Size.cachedPxImportant(this._getLayoutInfo().getAllocated().getWidth());
        },

        /**
         * @inheritDoc
         */
        _applyMeasure: function(mainSize, oppositeSize) {
          this._styleRules[".g_measured #w_" + this._widget.getUniqueIdentifier() + ".g_measureable"] = {
            height: mainSize + "px",
            width: oppositeSize + "px"
          };
          this._getLayoutInfo().setMeasured(oppositeSize, mainSize);
        },

        /**
         * @inheritDoc
         */
        _isStretched: function(widget) {
          return widget.getLayoutEngine().isXStretched();
        }
      };
    });
  });
