class ReservationController < ApplicationController
    def index
        @seats = Seat.all
    end

    def delete_all_reservations
        if Reservation.delete_all
            render json: { message: 'All reservations deleted successfully' }
        else
            render json: { errors: 'Failed to delete reservations' }, status: :unprocessable_entity
        end
    end
end
