<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->text('mood')->nullable(); // Voeg mood toe
            $table->integer('cijfer')->nullable(); // Voeg cijfer toe
            $table->string('profile_picture')->nullable(); // Voeg profile_picture toe
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['mood', 'cijfer', 'profile_picture']);
        });
    }
};
