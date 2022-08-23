<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ApiController;

Route::prefix('v1')->group(function () {
     Route::get('index',[ApiController::class,"index"]);
     Route::get('popular',[ApiController::class,"popular"]);
     Route::get('new',[ApiController::class,"newest"]);
     Route::get('category/{id}',[ApiController::class,"category"]);
     Route::get('post/{id}',[ApiController::class,"post"]);
     Route::get('search/{text}',[ApiController::class,"search"]);
Route::get('policy',[ApiController::class,"policy"]);
Route::get('about-us',[ApiController::class,"about"]);
Route::post('register',[ApiController::class,"saveDevice"]);
});
