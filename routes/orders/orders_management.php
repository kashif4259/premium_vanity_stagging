<?php

use App\Http\Controllers\API\OrdersManagementController;

Route::get('orders', [OrdersManagementController::class, 'ordersManagementView']);

Route::post('/sales-list-data/{id}', [OrdersManagementController::class, 'salesListGetData']);
