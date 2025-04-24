<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Wish;

class WishlistController extends Controller
{
    public function index()
    {
        $wishes = Wish::with('user:id,name,mood,profile_picture')->get();

        return response()->json($wishes);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
        ]);

        $wish = Wish::create([
            'user_id' => auth()->id(),
            'title' => $validated['title'],
            'description' => $validated['description'],
        ]);

        return response()->json($wish, 201);
    }
}
