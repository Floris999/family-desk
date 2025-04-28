<script setup>
import Navbar from "@/components/inc/Navbar.vue";
import FormWishlist from "@/components/FormWishlist.vue";
</script>

<template>
    <div class="min-h-full">
        <NavBar />
        <header class="bg-white shadow-sm">
            <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                <h1 class="text-3xl font-bold tracking-tight text-gray-900">
                    Voeg een idee toe
                </h1>
            </div>
        </header>
        <main>
            <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                <FormWishlist />
            </div>
        </main>
    </div>
</template>
