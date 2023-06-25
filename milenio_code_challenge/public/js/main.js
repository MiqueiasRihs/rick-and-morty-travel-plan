$(document).ready(function() {
    var currentPath = window.location.pathname;

    if(window.location.search) {
      currentPath = currentPath + window.location.search
    }

    $("#navbar ul a").each(function() {
        if ($(this).attr("href") === currentPath) {
        $(this).children().addClass("active");
      }
    });
});

function getCheckBoxValues() {
    var checkboxes = document.querySelectorAll('.list-locations input[type="checkbox"]');
    var values = [];
  
    checkboxes.forEach(function(checkbox) {
      if (checkbox.checked) {
        values.push(parseInt(checkbox.value));
      }
    });

    return values;
}

function uncheckBoxes() {
    var checkboxes = document.querySelectorAll('.list-locations input[type="checkbox"]');
  
    checkboxes.forEach(function(checkbox) {
      checkbox.checked = false;
    });
}

function saveTravelPlan() {
    list_stops = getCheckBoxValues()
    $.ajax({
        url: '/travel_plans',
        method: 'POST',
        datatype: 'json',
        headers: {"Content-Type": "application/json"},
        data: JSON.stringify({"travel_stops": list_stops}),
        beforeSend: function(){},
        success: function(data) {
            uncheckBoxes()
            Swal.fire({
                title: 'Salvo!',
                text: 'Seu plano de viagem foi salvo',
                icon: 'success',
                showConfirmButton: false,
                timer: 1500
            })

            setTimeout(function() {
              window.location.href = "/meus_planos?expand=true";
            }, 1600);
        }
    });
}

function saveEditTravelPlan(id) {
  list_stops = getCheckBoxValues()
  $.ajax({
      url: `/travel_plans/${id}`,
      method: 'PUT',
      datatype: 'json',
      headers: {"Content-Type": "application/json"},
      data: JSON.stringify({"travel_stops": list_stops}),
      beforeSend: function(){},
      success: function(data) {
          uncheckBoxes()
          Swal.fire({
              title: 'Salvo!',
              text: 'Seu plano de viagem foi salvo',
              icon: 'success',
              showConfirmButton: false,
              timer: 1500
          })

          setTimeout(function() {
            window.location.href = "/meus_planos?expand=true";
          }, 1600); 
      }
  });
}

function deleteTravelPlan(id) {
  $.ajax({
      url: `/travel_plans/${id}`,
      method: 'DELETE',
      datatype: 'json',
      headers: {"Content-Type": "application/json"},
      beforeSend: function(){},
      success: function(data) {
          uncheckBoxes()
          Swal.fire({
              title: 'Deletado!',
              text: 'Seu plano de viagem foi deletado',
              icon: 'success',
              showConfirmButton: false,
              timer: 1500
          })
          setTimeout(function() {
            window.location.reload();
          }, 1500);
      }
  });
}