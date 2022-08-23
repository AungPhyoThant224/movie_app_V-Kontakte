<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\AdvertimentController;
use App\Http\Controllers\NotificationController;
use App\Models\Setting;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

$d=Setting::where("active","1")->first();
if($d){
\Config::set("app.name",$d->name);
\Config::set("app.logo",$d->logo);
\Config::set("app.contact",$d->contact);
\Config::set("app.dlink",$d->dlink);
}
Route::get('/', function () {
    return view('welcome');
});

Auth::routes([

  'register' => false, // Register Routes...

  'reset' => false, // Reset Password Routes...

  'verify' => false, // Email Verification Routes...

]);

Route::controller(HomeController::class)->group(function () {
Route::post('/generate-token',"generateToken")->name("generate-token");
Route::get('/home', 'index')->name('home');
Route::get('/setting','setting')->name('setting');
Route::put('/setting/{id}','updateSetting')->name('us');
Route::post('/change-password',"changePassword")->name('cp');
Route::post('/change-info',"changeMail")->name('ci');
Route::get('/callback','callback')->name("callback");
Route::prefix('admin')->group(function () {
Route::get('/create','createA')->name('admin-create');
Route::post('/create','createAP');
Route::get('list','adminList')->name('admin-list');
});
Route::get('video/{id}','video');
});

Route::controller(PostController::class)->group(function () {
	Route::prefix('post')->group(function () {
	Route::get("list","list")->name("post-list");
	Route::get("create","create")->name("post-create");
        Route::post("create","save");
	Route::prefix('{id}')->group(function () {
	Route::get("view","view")->name("post-view");
	Route::put("edit","edit")->name("post-edit");
	Route::delete("delete","delete")->name("post-delete");
	});
	});
});
Route::controller(CategoryController::class)->group(function () {
        Route::prefix('category')->group(function () {
	Route::get("list","list")->name("category-list");
        Route::get("create","create")->name("category-create");
        Route::post("create","save");
	Route::prefix('{id}')->group(function () {
        Route::get("view","view")->name("category-view");
        Route::put("edit","edit")->name("category-edit");
        Route::delete("delete","delete")->name("category-delete");
        });
        });
});
Route::controller(AdvertimentController::class)->group(function () {
        Route::prefix('advertisement')->group(function () {
        Route::get("list","list")->name("ads-list");
        Route::get("create","create")->name("ads-create");
        Route::post("create","save");
        Route::prefix('{id}')->group(function () {
        Route::get("view","view")->name("ads-view");
        Route::put("edit","edit")->name("ads-edit");
        Route::delete("delete","delete")->name("ads-delete");
        });
        });
});
Route::controller(NotificationController::class)->group(function () {
        Route::prefix('notification')->group(function () {
        Route::get("list","list")->name("notification-list");
        Route::get("create","create")->name("notification-create");
        Route::post("create","save");
        Route::prefix('{id}')->group(function () {
        Route::get("view","view")->name("notification-view");
        Route::put("edit","edit")->name("notification-edit");
        Route::delete("delete","delete")->name("notification-delete");
        });
        });
});
