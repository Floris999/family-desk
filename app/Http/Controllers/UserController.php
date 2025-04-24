<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function index()
    {
        return response()->json(User::all());
    }

    public function getAuthenticatedUser()
    {
        $user = Auth::user(); // Haal de ingelogde gebruiker op

        if (!$user) {
            return response()->json(['message' => 'No authenticated user found'], 404);
        }

        return response()->json($user);
    }
}
