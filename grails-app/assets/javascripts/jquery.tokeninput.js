/*! tokeninput - v0.1.0 - 2015-02-09
* Copyright (c) 2015 Paulo Leal; Licensed GPL */
(function ($) {
  $.tokeninput = {
    defaultOptions: {
      fromListOnly: false, //allows input only from items in the source list
      class: '', //adds this class to tokeninput whole div block
      placeholder: '', //placeholder to show inside tokeninput's input field
      source: [], //a list of options to show. Must be in the following format: {displayName: "name to display after selected", listingName: "name on the list", value: 'value of input field'}
      preadd: [] //a list of values to be pre added. same format as above
    }
  };

  $.fn.tokeninput = function (options) {
    // Class names to apply css
    var CLASS_PREFIX = 'tokeninput';
    var CONTENT_CLASS = CLASS_PREFIX + '-content';
    var INPUT_FIELD_CLASS = CLASS_PREFIX + '-input-field';
    var HIDDEN_FIELDS_CLASS = CLASS_PREFIX + '-hidden-fields';
    var VISIBLE_LABELS_CLASS = CLASS_PREFIX + '-visible-labels';
    var DELETE_FIELD_CLASS = CLASS_PREFIX + '-delete';
    var OPTIONS_BOX_CLASS = CLASS_PREFIX + '-options';
    var OPTIONS_BOX_ITEMS_CLASS = CLASS_PREFIX + '-options-item';
    var NAVIGATION_SELECTION_CLASS = CLASS_PREFIX + '-navigation-selection';
    // fancy
    var CURRENT_SELECTION_DATA_ATTRIBUTE = 'data-current-selected-option';

    options = $.extend({}, $.tokeninput.defaultOptions, options);

    var createDiv = function (params) {
      return $("<div></div>", params);
    };

    var createUl = function (params) {
      return $("<ul></ul>", params);
    };

    var createBlock = function (obj) {
      var block = createDiv({class: CLASS_PREFIX + " " + options.class});
      var contentDiv = createDiv({class: CONTENT_CLASS});
      contentDiv.append(createDiv({class: HIDDEN_FIELDS_CLASS}).hide());
      contentDiv.append(createUl({class: VISIBLE_LABELS_CLASS}));
      var newInput = obj.clone().removeAttr('name').addClass(INPUT_FIELD_CLASS);
      if (options.placeholder) {
        newInput.attr('placeholder', options.placeholder);
      }
      contentDiv.append(newInput);
      block.append(contentDiv);
      return block;
    };

    return this.each(function () {
      var obj = $(this);
      var inputName = obj.attr('name');

      var optionsBox = null;
      var block = createBlock(obj);
      var content = block.find("." + CONTENT_CLASS);
      var prev = obj.prev();
      obj.remove();
      block.insertAfter(prev);
      var searchDelayTimer = null;
      var currentSource = null;

      var findByValue = function (value) {
        var _ret = false;
        content.find("." + HIDDEN_FIELDS_CLASS + " > input").each(function () {
          if ($(this).val() === value) {
            _ret = true;
          }
        });
        return _ret;
      };

      var removeEntry = function (event, index) {
        var me = $(this);
        if (index == null) {
          index = content.find(".tokeninput-visible-labels > li").toArray().indexOf(me.parent()[0]);
        }
        $(content.find("." + HIDDEN_FIELDS_CLASS + " > input")[index]).remove();
        $(content.find("." + VISIBLE_LABELS_CLASS + " > li")[index]).remove();
      };

      var addEntry = function (inputName, displayName, value) {
        var closeButton = $("<span></span>", {class: DELETE_FIELD_CLASS}).html('x');
        closeButton.on('click', removeEntry);

        var inputAttributes = {name: inputName, type: 'hidden', value: value};

        if (currentSource) {
          currentSource.forEach(function (each) {
            if (each.displayName === displayName) {
              inputAttributes.value = each.value;
            }
          });
        }
        var inputObject = $("<input/>", inputAttributes)
          .attr('data-displayName', displayName);
        var li = $("<li></li>")
          .html(displayName)
          .append(closeButton);

        content.find("." + HIDDEN_FIELDS_CLASS).append(inputObject);
        content.find("." + VISIBLE_LABELS_CLASS).append(li);
        showListIfSource();

        if (!$.tokeninput.preventFocus) {
          content.find("." + INPUT_FIELD_CLASS).focus();
        }
      };

      var updateOptionsList = function () {
        currentSource = null;
        var source = [];

        if (searchDelayTimer) {
          searchDelayTimer = clearTimeout(searchDelayTimer);
        }

        searchDelayTimer = setTimeout(function () {
          var search = content.find("." + INPUT_FIELD_CLASS).val();
          if (typeof(options.source) === "function") {
            source = options.source(search);
            $.when(source).done(function (result) {
              _updateOptionsList(result);
            });
          } else if (typeof(options.source) === "object") {
            source = $.grep(options.source, function (it) {
              return it.listingName.toLowerCase().indexOf(search.toLowerCase()) >= 0;
            });
            _updateOptionsList(source);
          } else {
            //console.error("unrecognized source");
          }
        }, 100);
      };

      var _updateOptionsList = function (source) {
        if (!source) {
          optionsBox.hide();
        }

        currentSource = source;
        optionsBox.find("li").remove();
        $(source).each(function (index, value) {
          if (!content.find("." + HIDDEN_FIELDS_CLASS).find("[data-displayname='" + value.displayName + "']").length) {

            var el = $("<li></li>", {class: OPTIONS_BOX_ITEMS_CLASS})
              .html(value.listingName)
              .data('displayName', value.displayName)
              .data('value', value.value);

            el.on('click', function () {
              var me = $(this);
              addEntry(inputName, me.data('displayName'), me.data('value'));
              showListIfSource();
            });
            optionsBox.append(el);
          }
        });
      };

      var hideList = function () {
        if (optionsBox) {
          optionsBox.hide();
        }
      };

      var showListIfSource = function () {
        if (!options.source || options.source.length === 0) {
          return;
        }

        if (!optionsBox) {
          optionsBox = createUl({class: OPTIONS_BOX_CLASS}).hide();
          block.append(optionsBox);
        }

        updateOptionsList();

        $.tokeninput.requestedToShowList = true;
        $("." + OPTIONS_BOX_CLASS).hide();
        optionsBox = optionsBox.show();
      };

      var handledSelectedNavigationOption = function () {
        var selection = optionsBox.find("[" + CURRENT_SELECTION_DATA_ATTRIBUTE + "]:eq(0)");
        selection.addClass(NAVIGATION_SELECTION_CLASS);
        content.find("." + INPUT_FIELD_CLASS).val(selection.html());
      };

      var handleKeyUp = function () {
        var currentNavigationItem = optionsBox.find("[" + CURRENT_SELECTION_DATA_ATTRIBUTE + "]");
        if (currentNavigationItem.length) {
          if (currentNavigationItem.prev()[0]) {
            currentNavigationItem.removeClass(NAVIGATION_SELECTION_CLASS);
            currentNavigationItem.removeAttr(CURRENT_SELECTION_DATA_ATTRIBUTE);
            currentNavigationItem.prev().attr(CURRENT_SELECTION_DATA_ATTRIBUTE, '1');
            handledSelectedNavigationOption();
          }
        }
      };

      var handleKeyDown = function () {
        var currentNavigationItem = optionsBox.find("[" + CURRENT_SELECTION_DATA_ATTRIBUTE + "]");
        if (currentNavigationItem.length) {
          if (currentNavigationItem.next()[0]) {
            currentNavigationItem.removeClass(NAVIGATION_SELECTION_CLASS);
            currentNavigationItem.removeAttr(CURRENT_SELECTION_DATA_ATTRIBUTE);
            currentNavigationItem.next().attr(CURRENT_SELECTION_DATA_ATTRIBUTE, '1');
            handledSelectedNavigationOption();
          }
        } else {
          optionsBox.children().first().attr(CURRENT_SELECTION_DATA_ATTRIBUTE, '1');
          handledSelectedNavigationOption();
        }

      };

      content.find("." + INPUT_FIELD_CLASS)
        .on('keyup', function (e) {
          var keyCode = e.which;

          if (keyCode >= 48 && keyCode <= 90 || keyCode === 8 || keyCode === 46) {
            updateOptionsList();
          } else if (keyCode === 38) {
            handleKeyUp();
          } else if (keyCode === 40) {
            handleKeyDown();
          }
        })
        .on('keydown', function (e) {
          var target = $(e.target);
          var keyCode = e.which;
          var interruptingKeys = [9, 188, 186, 13];

          if (keyCode === 8) {
            if (target.val() === "") {
              e.preventDefault();
              var tokensCount = content.find("." + DELETE_FIELD_CLASS).size();
              if (tokensCount > 0) {
                removeEntry(null, tokensCount - 1);
              }
            }
          }

          if (interruptingKeys.indexOf(keyCode) >= 0) {
            e.preventDefault();

            var displayName = target.val();
            var value = $(e.target).val();

            if (value.length && !findByValue(value)) {
              if (options.fromListOnly) {
                if (currentSource) {
                  currentSource.forEach(function (it) {
                    if (it.listingName === displayName) {
                      addEntry(inputName, displayName, value);
                      target.val('');
                    }
                  });
                }
              } else {
                addEntry(inputName, displayName, value);
                target.val('');
              }
            }
          }
        })
        .on('focus', showListIfSource)
        .on('blur', function () {
          $.tokeninput.requestedToShowList = false;
          setTimeout(function () {
            if (!$.tokeninput.requestedToShowList) {
              hideList();
            }
          }, 300);
        });

      if (options.preadd) {
        $.tokeninput.preventFocus = true;
        options.preadd.forEach(function (each) {
          addEntry(inputName, each.displayName, each.value);
        });
        $.tokeninput.preventFocus = false;
        hideList();
      }

    });
  };

}(jQuery));
