<?php
//product module
use App\Http\Controllers\API\TodoListController;

Route::group(['prefix' => 'todos'], function () {
    Route::get('/', [TodoListController::class, 'listingView']);
    Route::post('store', [TodoListController::class, 'store']);
    Route::post('update-status', [TodoListController::class, 'upDateStatus']);
    Route::post('delete', [TodoListController::class, 'deleteData']);
    Route::post('set-due-date', [TodoListController::class, 'setDueDate']);
    Route::get('list', [TodoListController::class, 'getTodoData']);
    Route::get('support-data', [TodoListController::class, 'getSupportData']);
    Route::get('filters', [TodoListController::class, 'getTodoFilter']);
});