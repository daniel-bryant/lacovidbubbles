window.openInfoWindows = [];

window.initMap = function () {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 34.05, lng: -118.25 },
    zoom: 11,
  });

  fetch('/parses/latest.json')
    .then(response => response.json())
    .then(data => {
      for (const datum of data.data) {
        const infowindow = new google.maps.InfoWindow({
          content: '<h3>' + datum.name + '</h3>' + '<h4>' + datum.address + '</h4>',
        });

        const marker = new google.maps.Marker({
          label: datum.total_staff.toString(),
          map: map,
          position: {
            lat: parseFloat(datum.position.latitude),
            lng: parseFloat(datum.position.longitude),
          },
          title: datum.name,
        });

        marker.addListener("click", () => {
          for (const w of openInfoWindows) w.close();
          openInfoWindows = [];

          openInfoWindows.push(infowindow);
          infowindow.open(map, marker);
        });
      }
    });
}
