map = null
info = null
res = null
neightboor = null
chosenCity = null
#remove when mock finish
lillecoo = null
#end
@resetHover = (e) ->
  layer = e.target
  layer.setStyle({fillOpacity: 0.3})
  info.clear()

@customHover = (e) ->
  layer = e.target
  layer.setStyle({fillOpacity: 0.6})
  info.update(layer.options.properties)

@myAlert = (e) ->
  chosenCity.remove()
  for elem in neightboor
    elem.remove()
  drawRegion(e.layer.feature.properties.nom)

@drawRegion = (citytext) ->
  res = mockServerCall(citytext) # send "Lille" receive  [lilleGeoJson,[neighbour1_geojson,neighbour2_geojson...]]
  #draw the correct geoJSON
  realPolygon = L.geoJSON(res[0].chosenCity[1])
  res[0].chosenCity[1].geometry.coordinates = [
    [[-150,-150],[150,-150],[150,150],[-150,150]],
    res[0].chosenCity[1].geometry.coordinates[0]
  ]
  chosenCity = L.geoJSON(res[0].chosenCity[1],{
    style: (feature) ->
        return {color: "black",fillOpacity: 0.15,weight: 1.5};
  }).addTo(map);
  # remove when mock finish
  lilleGeoJson.geometry.coordinates = lillecoo
  # end
  map.fitBounds(realPolygon.getBounds())
  # draw neighboor
  neightboor = []
  for elem in res[0].neighboor
    neightboor.push(L.geoJSON(elem[1],{
      style: (feature) ->
          return {color: "black",weight: 1,fillOpacity: 0.2};
    }).addTo(map).on({
        click: myAlert
    }))
  mockCallBack(chosenCity,neightboor)

@makeLeafletControl = () ->
  info = L.control();
  info.onAdd = (map) ->
      this._div = L.DomUtil.create('div', 'info');
      this.update();
      return this._div;

  info.update = (prop) ->
    if prop != undefined
      this._div.innerHTML = """
      <div class="collection">
        <div class="collection-item">Nom de la commune : #{prop.nom_commune}</div>
        <div class="collection-item">Surface habitable : #{prop.surf_ha}</div>
      </div>
      """
  info.clear = () ->
    this._div.innerHTML = """
    <div class="collection">
      <div class="collection-item">Vide</div>
    </div>
    """

  info.addTo(map);

$ ->
  lillecoo = lilleGeoJson.geometry.coordinates
  #default behaviour -> adding actions
  map = L.map('map').setView([45.9114, -1.2529], 11);
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  # uncomment if you want to start directly in Lille
  # drawRegion("Lille")
  
  makeLeafletControl()
