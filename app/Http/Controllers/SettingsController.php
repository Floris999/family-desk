<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class SettingsController extends Controller
{
    public function update(Request $request)
    {
        $user = Auth::user();

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
            'mood' => 'nullable|string',
            'cijfer' => 'nullable|integer|min:1|max:10',
            'photo' => 'nullable|image|max:10240', // Max 10MB
            'role' => 'nullable|string|max:255',
        ]);

        // Verwerk de profielfoto
        if ($request->hasFile('photo')) {
            if ($user->profile_picture) {
                Storage::disk('public')->delete($user->profile_picture); // Verwijder oude foto
            }
            $path = $request->file('photo')->store('profile_pictures', 'public'); // Opslaan in de public disk
            $validated['profile_picture'] = $path;
        }

        $user->update($validated);

        return response()->json(['message' => 'Profile updated successfully', 'user' => $user], 200);
    }
}