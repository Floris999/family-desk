<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";

const wishes = ref([]);

const fetchWishes = async () => {
  try {
    const response = await axios.get("/wishes");
    wishes.value = response.data;
    console.log(wishes.value);
  } catch (error) {
    console.error("Fout bij het ophalen van wensen:", error);
  }
};

onMounted(() => {
  fetchWishes();
});
</script>

<template>
  <ul role="list" class="divide-y divide-gray-100">
    <li v-for="wish in wishes" :key="wish.id" class="flex justify-between gap-x-6 py-5">
      <div class="flex min-w-0 gap-x-4">
        <img class="size-12 flex-none rounded-full bg-gray-50" :src="wish.user.profile_picture" alt="" />
        <div class="min-w-0 flex-auto">
          <p class="text-sm/6 font-semibold text-gray-900">{{ wish.user.name }}</p>
          <p class="mt-1 truncate text-xs/5 text-gray-500">{{ wish.user.mood }}</p>
          <p class="sm:hidden mt-1 truncate text-xs/5 text-gray-900">{{ wish.title }}</p>
          <p class="sm:hidden text-sm/6 text-gray-900">{{ wish.status }}</p>
        </div>
      </div>
      <div class="hidden shrink-0 sm:flex sm:flex-col sm:items-end">
        <p class="text-sm/6 text-gray-900">{{ wish.title }}</p>
        <p class="mt-1 text-xs/5 text-gray-500">
          {{ wish.description }}
        </p>
        <p class="text-sm/6 text-gray-900">{{ wish.status }}</p>
      </div>
    </li>
  </ul>
  <p class="mt-6 text-lg/8 text-gray-600">
    Voor family desk ben ik altijd zoekende naar nieuwe toevoegingen. Je kan deze met de knop hieronder aanmelden. Heb
    je een fout in de family desk gevonden? Voeg ook deze toe als idee om een melding te maken.
  </p>
  <p class="mt-6 text-lg/8 text-gray-900">
    Heb je een fout in de family desk gevonden? Voeg ook deze toe als idee om een melding te maken.
  </p>
  <div class="flex d-flex mt-8">
    <router-link to="/add-wish" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
      Idee toevoegen
    </router-link>
  </div>
</template>
