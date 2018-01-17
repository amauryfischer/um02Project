# this function should take a string in entry ex: "Lille"
# and return :
# [
#   chosenCity: ["Lille",lilleGeoJson],
#   neighboor: [
#     ["voisin1",voisin1GeoJson],
#     ["voisin2",voisin2GeoJson],
#     ....
#   ]
#]
window.mockTime = 0
@mockServerCall = (citytext) ->
  window.mockTime = window.mockTime + 1
  if window.mockTime == 1
    return [
      chosenCity: ["Lille",lilleGeoJson],
      neighboor: [
        ["Englos",englosGeoJson],
        ["Pérenchies",perenchiesGeoJson],
        ["Ennetières-en-Weppes",ennentiereGeoJson],
        ["Lambersart",lambersartGeoJson],
        ["Capinghem",capinghemGeoJson],
        ["Saint-André-lez-Lille",saintandreGeoJson],
        ["Sequedin",sequedinGeoJson],
        ["Lezennes",lezenneGeoJson],
        ["Villeneuve-d'Ascq",villeneuveGeoJson],
        ["Loos",loosGeoJson],
        ["Mons-en-Barœul",monsGeoJson],
        ["La Madeleine",madeleineGeoJson],
        ["Lompret",lompretGeoJson],
        ["Faches-Thumesnil",fachesGeoJson],
        ["Prémesques",premesquesGeoJson],
        ["Marcq-en-Barœul",marcGeoJson],
        ["Ronchin",ronchinGeoJson],
        ["Wattignies",wattigniesGeoJson]
      ]
    ]
  else
    return [
      chosenCity: ["Mons-en-Barœul",monsGeoJson],
      neighboor: [
        ["Lille",lilleGeoJson],
        ["Villeneuve-d'Ascq",villeneuveGeoJson],
        ["Marcq-en-Barœul",marcGeoJson]
      ]
    ]
@mockCallBack = (chosenCity,neightboor) ->
  $("#test5").html(chosenCity._layers[chosenCity._leaflet_id - 1].feature.properties.surf_ha)
  names = ""
  for elem in neightboor
    names += elem._layers[elem._leaflet_id - 1].feature.properties.nom + " "
  $("#mCardContent").html(names)
  #callBack if you need to implement it to display data each time
