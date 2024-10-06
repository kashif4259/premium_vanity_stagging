<?php

use App\Http\Controllers\API\OrdersManagementController;

Route::group(['prefix' => 'orders'], function(){
    Route::get('/', [OrdersManagementController::class, 'ordersManagementView'])->name('orders.management');
    Route::get('/getDetails/{id}', [OrdersManagementController::class, 'getOrderDetails']);
    Route::post('/variantDetails/{id}', [OrdersManagementController::class, 'getVariantDetails']);
    Route::post('/audit/details/{id}', [OrdersManagementController::class, 'getOrderAuditDetails']);
    Route::post('/sales-list-data/{id}', [OrdersManagementController::class, 'salesListGetData']);
    Route::get('/getPackingSlipDetails/{id}', [OrdersManagementController::class, 'getPackingSlipDetails']);
    Route::post('/updateOrderStatus/{id}', [OrdersManagementController::class, 'updateOrderStatus']);
    Route::post('/sales/list/delete/{id}', [OrdersManagementController::class, 'saleListDelete']);
    Route::get('/{id}/edit', [OrdersManagementController::class, 'editOrder']);

    Route::post('/{id}/update', [OrdersManagementController::class, 'updateOrder']);

    Route::get('/getInvoiceDetails/{id}', [OrdersManagementController::class, 'getInvoiceDetails']);

    Route::get('/getPaymentsHistory/{id}', [OrdersManagementController::class, 'getPaymentsHistory']);
});


