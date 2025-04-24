<script setup>
import NavBar from "@/components/inc/NavBar.vue";
import Settings from "@/components/Settings.vue";
</script>

<template>
    <div class="min-h-full">
        <NavBar />
        <header class="bg-white shadow-sm">
            <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                <h1 class="text-3xl font-bold tracking-tight text-gray-900">
                    Settings
                </h1>
            </div>
        </header>
        <main>
            <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                <Settings />
            </div>
        </main>
    </div>
</template>
