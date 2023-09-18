class SeatController < ApplicationController
    def update_state
        seat = Seat.find(params[:seat_id])
        new_state = params[:state]

        if seat.update(state: new_state, session_token: (new_state == "free" ? "" : params[:session_token]))
            ActionCable.server.broadcast('reserve_channel', { seat_id: seat.id, state: new_state, session_token: params[:session_token] })
            head :no_content
        else
            render json: { errors: seat.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def create_reservation
        name = params[:reservation_name]
        email = params[:reservation_email]
        seat_id = params[:seat_id]
        
        reservation = Reservation.create(reservation_name: name, reservation_email: email, seat_id: seat_id)
        
        if reservation.save
            render json: { message: "Reservation created successfully" }
        else
            render json: { errors: reservation.errors.full_messages }
        end
    end

    def reset_all_seats
        new_state = params[:state]

        if Seat.update_all(state: new_state, session_token: "")
            ActionCable.server.broadcast('reserve_channel', { seat_id: 'all', state: new_state, reset_seats: params[:reset_seats] })
            head :no_content
        else
            render json: { errors: 'Failed to reset seats' }
        end
    end
end
