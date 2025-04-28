<script setup>
import Navbar from "@/components/inc/Navbar.vue";
import UserOverview from "@/components/UserOverview.vue";
</script>

<template>
  <div class="min-h-full">
    <Navbar />
    <header class="bg-white shadow-sm">
      <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
        <h1 class="text-3xl font-bold tracking-tight text-gray-900">Dashboard</h1>
      </div>
    </header>
    <main>
      <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
        <UserOverview />
      </div>
    </main>
  </div>
</template>
