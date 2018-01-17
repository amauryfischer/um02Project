var chosenCity, info, lillecoo, map, neightboor, res;

map = null;

info = null;

res = null;

neightboor = null;

chosenCity = null;

//remove when mock finish
lillecoo = null;

//end
this.resetHover = function(e) {
  var layer;
  layer = e.target;
  layer.setStyle({
    fillOpacity: 0.3
  });
  return info.clear();
};

this.customHover = function(e) {
  var layer;
  layer = e.target;
  layer.setStyle({
    fillOpacity: 0.6
  });
  return info.update(layer.options.properties);
};

this.myAlert = function(e) {
  var elem, i, len;
  chosenCity.remove();
  for (i = 0, len = neightboor.length; i < len; i++) {
    elem = neightboor[i];
    elem.remove();
  }
  return drawRegion(e.layer.feature.properties.nom);
};

this.drawRegion = function(citytext) {
  var elem, i, len, realPolygon, ref;
  res = mockServerCall(citytext); // send "Lille" receive  [lilleGeoJson,[neighbour1_geojson,neighbour2_geojson...]]
  //draw the correct geoJSON
  realPolygon = L.geoJSON(res[0].chosenCity[1]);
  res[0].chosenCity[1].geometry.coordinates = [[[-150, -150], [150, -150], [150, 150], [-150, 150]], res[0].chosenCity[1].geometry.coordinates[0]];
  chosenCity = L.geoJSON(res[0].chosenCity[1], {
    style: function(feature) {
      return {
        color: "black",
        fillOpacity: 0.15,
        weight: 1.5
      };
    }
  }).addTo(map);
  lilleGeoJson.geometry.coordinates = lillecoo;
  // end
  map.fitBounds(realPolygon.getBounds());
  // draw neighboor
  neightboor = [];
  ref = res[0].neighboor;
  for (i = 0, len = ref.length; i < len; i++) {
    elem = ref[i];
    neightboor.push(L.geoJSON(elem[1], {
      style: function(feature) {
        return {
          color: "black",
          weight: 1,
          fillOpacity: 0.2
        };
      }
    }).addTo(map).on({
      click: myAlert
    }));
  }
  return mockCallBack(chosenCity, neightboor);
};

this.makeLeafletControl = function() {
  info = L.control();
  info.onAdd = function(map) {
    this._div = L.DomUtil.create('div', 'info');
    this.update();
    return this._div;
  };
  info.update = function(prop) {
    if (prop !== void 0) {
      return this._div.innerHTML = `<div class="collection">\n  <div class="collection-item">Nom de la commune : ${prop.nom_commune}</div>\n  <div class="collection-item">Surface habitable : ${prop.surf_ha}</div>\n</div>`;
    }
  };
  info.clear = function() {
    return this._div.innerHTML = "<div class=\"collection\">\n  <div class=\"collection-item\">Vide</div>\n</div>";
  };
  return info.addTo(map);
};

$(function() {
  lillecoo = lilleGeoJson.geometry.coordinates;
  //default behaviour -> adding actions
  map = L.map('map').setView([45.9114, -1.2529], 11);
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);
  return makeLeafletControl();
});
