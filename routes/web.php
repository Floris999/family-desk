<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\SettingsController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\WishlistController;


Route::post('/register', [RegisterController::class, 'store']);

Route::post('/wishes', [WishlistController::class, 'store']);

Route::get('/users', [UserController::class, 'index']);

Route::post('/login', [LoginController::class, 'authenticate']);

Route::get('/logout', [LoginController::class, 'logout'])->name('logout');

Route::get('/wishes', [WishlistController::class, 'index']);

Route::get('/user', [UserController::class, 'getAuthenticatedUser'])->middleware('auth');

Route::middleware('auth')->post('/settings/update', [SettingsController::class, 'update']);

Route::get('/{any}', function () {
    return view('app');
})->where('any', '.*');
