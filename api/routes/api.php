<?php

use App\Notifications\LikeNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('notifications/like', function () {
    Notification::route('mail', 'fouladgar.dev@gmail.com')
                ->notify(new LikeNotification('Danial,Hamed and Ahmad liked your post.'));

    return response()->json([
        'data'=> 'Notification sent via mail successfully.',
    ], 200);
});
