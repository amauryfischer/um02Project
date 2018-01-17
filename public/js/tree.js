var currentSelection;

currentSelection = [];

this.updateSelectedList = function() {
  var selectedNodes;
  selectedNodes = $('#tree').treeview('getSelected');
  $("#selectedNodes").html("");
  currentSelection = [];
  return selectedNodes.forEach(function(elem, i) {
    var html;
    if (elem.nodes === void 0) {
      html = "<div class=\"collection-item\"> " + elem.text + " </div>";
      $("#selectedNodes").append(html);
      currentSelection.push(elem.text);
      return drawRegion(elem.text);
    }
  });
};

this.cleanListForOne = function(event, data) {
  var selectedNodes;
  selectedNodes = $('#tree').treeview('getSelected');
  if (selectedNodes.length > 1 && data.nodes === void 0) {
    selectedNodes.forEach(function(elem, i) {
      if (elem.nodes === void 0) {
        return $('#tree').treeview('unselectNode', [
          elem.nodeId, {
            silent: true
          }
        ]);
      }
    });
    return $('#tree').treeview('selectNode', [
      data.nodeId, {
        silent: true
      }
    ]);
  }
};

this.customOnNodeSelected = function(event, data) {
  var id;
  if (data !== void 0) {
    id = data.nodeId;
    if (data.nodes !== void 0) {
      if (data.state.expanded) {
        return $('#tree').treeview('collapseNode', [id, {}]);
      } else {
        return $('#tree').treeview('expandNode', [
          id, {
            levels: 1
          }
        ]);
      }
    } else {
      cleanListForOne(event, data);
      return updateSelectedList();
    }
  }
};

this.mySearch = function(searchText) {
  return $('#tree').treeview('search', [
    searchText, {
      ignoreCase: true,
      exactMatch: false,
      revealResults: true
    }
  ]);
};

$(function() {
  $("#search").keydown(function(e) {
    var text;
    text = $(this).val();
    if (text.length > 3) {
      return mySearch(text);
    }
  });
  $("#search").keyup(function(e) {
    var text;
    text = $(this).val();
    if (text.length > 3) {
      return mySearch(text);
    }
  });
  M.toast({
    html: 'init treeview from api/json'
  });
  return $('#tree').treeview({
    highlightSelected: true,
    expandIcon: "fas fa-chevron-right",
    multiSelect: true,
    collapseIcon: "fas fa-chevron-down",
    levels: 0,
    onNodeSelected: function(event, data) {
      return customOnNodeSelected(event, data);
    },
    onNodeUnselected: function(event, data) {
      return customOnNodeSelected(event, data);
    },
    data: [
      {
        text: "&nbsp;&nbsp;France",
        selectedBackColor: "#42b1ca",
        nodes: [
          {
            text: "&nbsp;&nbsp;Aquitaine",
            selectedBackColor: "#42b1ca",
            nodes: [
              {
                text: "&nbsp;&nbsp;Gironde 1",
                selectedBackColor: "#42b1ca",
                nodes: [
                  {
                    text: "&nbsp;&nbsp;Bordeaux"
                  }, {
                    text: "&nbsp;&nbsp;Merignac"
                  }, {
                    text: "&nbsp;&nbsp;Pessac"
                  }
                ]
              }, {
                text: "&nbsp;&nbsp;Autre que Gironde",
                selectedBackColor: "#42b1ca",
                nodes: [
                  {
                    text: "&nbsp;&nbsp;Ville imaginaire"
                  }
                ]
              }
            ]
          }, {
            text: "&nbsp;&nbsp;Ile de france",
            selectedBackColor: "#42b1ca",
            nodes: [
              {
                text: "&nbsp;&nbsp;Arrondissement 42"
              }
            ]
          }
        ]
      }, {
        text: "&nbsp;&nbsp;Chine",
        selectedBackColor: "#42b1ca",
        nodes: []
      }, {
        text: "&nbsp;&nbsp;Espagne",
        selectedBackColor: "#42b1ca",
        nodes: []
      }, {
        text: "&nbsp;&nbsp;Pologne",
        selectedBackColor: "#42b1ca",
        nodes: []
      }, {
        text: "&nbsp;&nbsp;Portugal",
        selectedBackColor: "#42b1ca",
        nodes: []
      }
    ]
  });
});
