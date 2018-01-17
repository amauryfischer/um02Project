currentSelection = []

@updateSelectedList = () ->
  selectedNodes = $('#tree').treeview('getSelected')
  $("#selectedNodes").html("")
  currentSelection = []
  selectedNodes.forEach (elem,i) ->
    if elem.nodes == undefined
      html = """
      <div class="collection-item"> #{elem.text} </div>
      """
      $("#selectedNodes").append(html)
      currentSelection.push(elem.text)
      drawRegion(elem.text)

@cleanListForOne = (event,data) ->
  selectedNodes = $('#tree').treeview('getSelected')
  if selectedNodes.length > 1 && data.nodes == undefined
    selectedNodes.forEach (elem,i) ->
      if elem.nodes == undefined
        $('#tree').treeview('unselectNode', [ elem.nodeId, { silent: true } ]);
    $('#tree').treeview('selectNode', [ data.nodeId, { silent: true } ]);

@customOnNodeSelected = (event,data) ->
  if data != undefined
    id = data.nodeId
    if data.nodes != undefined #if is a children
      if data.state.expanded
        $('#tree').treeview('collapseNode', [ id, {} ]);
      else
        $('#tree').treeview('expandNode', [ id, { levels: 1} ]);
    else
      cleanListForOne(event,data)
      updateSelectedList()

@mySearch = (searchText) ->
  $('#tree').treeview('search', [ searchText, {
    ignoreCase: true,
    exactMatch: false,
    revealResults: true,
  }]);

$ ->

  $("#search").keydown (e) ->
    text = $(this).val()
    if text.length > 3
      mySearch(text)

  $("#search").keyup (e) ->
    text = $(this).val()
    if text.length > 3
      mySearch(text)

  M.toast({html: 'init treeview from api/json'})

  $('#tree').treeview({
    highlightSelected: true,
    expandIcon: "fas fa-chevron-right",
    multiSelect: true,
    collapseIcon: "fas fa-chevron-down",
    levels: 0,
    onNodeSelected: (event, data) ->
      customOnNodeSelected(event,data)
    ,
    onNodeUnselected: (event, data) ->
      customOnNodeSelected(event,data)
    ,
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
                  },
                  {
                    text: "&nbsp;&nbsp;Merignac"
                  },
                  {
                    text: "&nbsp;&nbsp;Pessac"
                  }
                ]
              },
              {
                text: "&nbsp;&nbsp;Autre que Gironde",
                selectedBackColor: "#42b1ca",
                nodes: [
                  {
                    text: "&nbsp;&nbsp;Ville imaginaire"
                  }
                ]
              }
            ]
          },
          {
            text: "&nbsp;&nbsp;Ile de france",
            selectedBackColor: "#42b1ca",
            nodes: [
              {
                text: "&nbsp;&nbsp;Arrondissement 42"
              }
            ]
          }
        ]
      },
      {
        text: "&nbsp;&nbsp;Chine",
        selectedBackColor: "#42b1ca",
        nodes: []
      },
      {
        text: "&nbsp;&nbsp;Espagne",
        selectedBackColor: "#42b1ca",
        nodes: []
      },
      {
        text: "&nbsp;&nbsp;Pologne",
        selectedBackColor: "#42b1ca",
        nodes: []
      },
      {
        text: "&nbsp;&nbsp;Portugal",
        selectedBackColor: "#42b1ca",
        nodes: []
      }
    ]
  });
