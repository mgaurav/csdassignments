#include "busController.h"

void BusController::insertBusRequest (BusRequest request) {
  requestQueue.push(request);
}

BusRequest BusController::selectRequest () {
  requestQueue.pop();
}
