<script setup>
// filepath: /Users/florisvandinteren-nuijten/Documents/projects/laravel/family-desk/resources/js/components/FormWishlist.vue
import axios from "axios";
import { ref, onMounted } from "vue";
import { useAuthStore } from "@stores/authStore";

const authStore = useAuthStore();

const form = ref({
  title: "",
  description: "",
});

const submitWish = async () => {
  try {
    const response = await axios.post("/wishes", {
      title: form.value.title,
      description: form.value.description,
    });

    console.log("Wens succesvol toegevoegd:", response.data);

    authStore.addWish(response.data);
    console.log(authStore.wishes);

    alert("Je wens is succesvol toegevoegd!");

    form.value.title = "";
    form.value.description = "";
  } catch (error) {
    console.error("Er is een fout opgetreden:", error);
  }
};
</script>

<template>
  <form @submit.prevent="submitWish">
    <div class="space-y-12">
      <div class="border-b border-gray-900/10 pb-12">
        <h2 class="text-base/7 font-semibold text-gray-900">Ik heb een idee</h2>
        <p class="mt-1 text-sm/6 text-gray-600">Beschrijf je idee kort maar duidelijk</p>

        <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
          <div class="sm:col-span-4">
            <label for="title" class="block text-sm/6 font-medium text-gray-900">Titel</label>
            <div class="mt-2">
              <div
                class="flex items-center rounded-md bg-white pl-3 outline-1 -outline-offset-1 outline-gray-300 focus-within:outline-2 focus-within:-outline-offset-2 focus-within:outline-indigo-600"
              >
                <input
                  v-model="form.title"
                  type="text"
                  name="title"
                  id="title"
                  class="block min-w-0 grow py-1.5 pr-3 pl-1 text-base text-gray-900 placeholder:text-gray-400 focus:outline-none sm:text-sm/6"
                  placeholder="Een familie chat"
                />
              </div>
            </div>
          </div>

          <div class="col-span-full">
            <label for="description" class="block text-sm/6 font-medium text-gray-900">Idee beschrijving</label>
            <div class="mt-2">
              <textarea
                v-model="form.description"
                name="description"
                id="description"
                rows="3"
                placeholder="Ik wil kunnen chatten met de hele familie!"
                class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
              ></textarea>
            </div>
          </div>
        </div>
      </div>

      <div class="mt-6 flex items-center justify-end gap-x-6">
        <router-link to="/wishlist" class="text-sm/6 font-semibold text-gray-900">Cancel</router-link>
        <button
          type="submit"
          class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        >
          Save
        </button>
      </div>
    </div>
  </form>
</template>
