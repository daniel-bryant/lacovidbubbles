window.openInfoWindows = [];

window.initMap = function () {
  const mapEl = document.getElementById("map");
  const url = mapEl.dataset.jsonUrl;

  const map = new google.maps.Map(mapEl, {
    center: { lat: 34.05, lng: -118.25 },
    zoom: 11,
  });

  fetch(url)
    .then(response => response.json())
    .then(data => {
      for (const datum of data.data) {
        const infowindow = new google.maps.InfoWindow({
          content: '<h6 class="title is-6">' + datum.name + '</h6>' +
          '<h6 class="subtitle is-6">' + datum.address + '</h6>' +
          '<h6 class="subtitle is-6">' + datum.total_staff.toString() + ' known staff cases' + '</h6>' +
          '<h6 class="subtitle is-6">' + datum.total_non_staff.toString() + ' known non-staff cases' + '</h6>',
        });

        const marker = new google.maps.Marker({
          label: (datum.total_staff + datum.total_non_staff).toString(),
          map: map,
          position: {
            lat: datum.location.latitude,
            lng: datum.location.longitude,
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

      for (const citation of data.citations) {
        const infowindow = new google.maps.InfoWindow({
          content: '<h6 class="title is-6">' + citation.name + '</h6>' +
          '<h6 class="subtitle is-6">' + citation.address + ', ' + citation.city + '</h6>' +
          '<h6 class="subtitle is-6">' + citation.activity_date + '</h6>',
        });

        const marker = new google.maps.Marker({
          map: map,
          position: {
            lat: citation.location.latitude,
            lng: citation.location.longitude,
          },
          title: citation.name,
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
