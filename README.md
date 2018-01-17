# Project for the course of UM02

Tree => Map :
-------------

Tree is communicating with the map by using the function drawRegion(citytext)
the drawRegion should receive the name of the city as a string

```
// citytext == string ex : drawRegion("Lille")
@drawRegion = (citytext) ->
```

Map => Server :
The map will call mockServerCall(nameofcity) with nameofcity = "Lille"
function mockServerCall
this function should take a string in entry ex: "Lille"
and should return :
```
[
 chosenCity: ["Lille",lilleGeoJson],
 neighboor: [
   ["voisin1",voisin1GeoJson],
   ["voisin2",voisin2GeoJson],
   ....
 ]
]
```
by an API call to the server,
right now, this is mocked...

Map => showData
---------------
mockCallBack is called at the end of the display drawRegion function in index.coffee

# carefull

GeoJSON spec dictates long, lat, while Leaflet uses lat, long. You'll have to deal with it.
