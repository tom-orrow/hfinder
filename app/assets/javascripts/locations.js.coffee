jQuery ($) ->
  prepare_map()

map = null
prepare_map = () ->
  # Load map
  mapOptions = {
    center: new google.maps.LatLng(55.755826, 37.6173),
    zoom: 11,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("map"), mapOptions)

  # Handle map click
  google.maps.event.addListener(map, "click", (e) ->
    loadNearbys(e.latLng)
  )

placeMarker = (location, click = false) ->
  new google.maps.Marker({
    position: location,
    map: map
  })

markers = []
loadNearbys = (location) ->
  $.each markers, (i, marker) ->
    marker.setMap(null)
  markers = []

  $.post('/nearbys', {
    lat: location.lat(),
    lng: location.lng()
  }).done (data) ->
    $('#locations tbody').html('')
    $.each data.locations, (i, loc) ->
      position = new google.maps.LatLng(loc.latitude, loc.longitude)
      marker = placeMarker(position)
      markers.push(marker)
      distance = Number((loc.distance).toFixed(2))
      $('#locations tbody').append('<tr id="loc_' + i + '"><td>' + loc.address + '</td><td>' + distance + '</td></tr>')
    $('[id^=loc_]').hover () ->
      i = $(this).attr('id').slice(4)
      markers[i].setAnimation(google.maps.Animation.BOUNCE)
    , () ->
      i = $(this).attr('id').slice(4)
      markers[i].setAnimation(null)
