<?php

use App\Http\Controllers\API\OrdersManagementController;

Route::group(['prefix' => 'orders'], function(){
    Route::get('/', [OrdersManagementController::class, 'ordersManagementView']);
    Route::get('/getDetails/{id}', [OrdersManagementController::class, 'getOrderDetails']);
    Route::post('/variantDetails/{id}', [OrdersManagementController::class, 'getVariantDetails']);
    Route::post('/sales-list-data/{id}', [OrdersManagementController::class, 'salesListGetData']);
    Route::get('/getPackingSlipDetails/{id}', [OrdersManagementController::class, 'getPackingSlipDetails']);
    Route::post('/updateOrderStatus/{id}', [OrdersManagementController::class, 'updateOrderStatus']);
    Route::post('/sales/list/delete/{id}', [OrdersManagementController::class, 'saleListDelete']);
});


