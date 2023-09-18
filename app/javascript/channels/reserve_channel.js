import consumer from "./consumer"

$(document).ready(function() {
  consumer.subscriptions.create("ReserveChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("WebSocket connected"); 
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channle
      const seatId = data.seat_id;
      const newState = data.state;
      const seatElement = $(`.seat[data-id="${seatId}"]`);

      if (data.reset_seats) {
          $('.seat').removeClass('seat-selected seat-selected_other seat-reserved').addClass('seat-free').css("background-color","").data( "session", "" );
          return;
      }

      if (seatElement.length) {
        seatElement.removeClass('seat-free seat-selected seat-selected_other seat-reserved').addClass("seat-" + newState);
      }
      if (newState == "reserved" ){
        seatElement.prop("title", data.reservation_name + '; ' + data.reservation_email);
      }
      if (data.session_token != sessionStorage.getItem('tabToken') && seatElement.hasClass("seat-selected")){
        seatElement.css("background-color","#ff2f2575");
      } else {
        seatElement.css("background-color","");
      }

    }
  });
});
