<script setup>
import { useAuthStore } from "@stores/authStore";
import { ref, onMounted } from "vue";
import axios from "axios";

const authStore = useAuthStore();

const userName = authStore.user?.name || "Onbekende gebruiker";
const userEmail = authStore.user?.email || "Geen email beschikbaar";
const userCijfer = authStore.user?.cijfer || "Geen cijfer beschikbaar";
const userMood = authStore.user?.mood || "Geen mood beschikbaar";
const userRole = authStore.user?.role || "Geen role beschikbaar";

const users = ref([]);
const averageCijfer = ref(0);

const fetchUser = async () => {
  try {
    const response = await fetch("/user", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
      credentials: "same-origin",
    });

    if (!response.ok) {
      throw new Error(`Fout bij het ophalen van de gebruiker: ${response.statusText}`);
    }

    const data = await response.json();
    authStore.login(data);
  } catch (error) {
    console.error("Fout bij het ophalen van de gebruiker:", error);
  }
};

const fetchUsers = async () => {
  try {
    const response = await axios.get("/users");
    users.value = response.data;

    const total = users.value.reduce((sum, user) => sum + (user.cijfer || 0), 0);
    averageCijfer.value = users.value.length ? total / users.value.length : 0;

    // Log de opgehaalde data naar de console
    console.log("Opgehaalde gebruikers:", response.data);
  } catch (error) {
    console.error("Fout bij het ophalen van gebruikers:", error);
  }
};

onMounted(() => {
  fetchUsers();
  fetchUser();
});
</script>

<template>
  <div class="bg-white py-8">
    <div class="mx-auto grid max-w-7xl gap-20 lg:px-8 xl:grid-cols-3">
      <div class="w-full p-4">
        <h2 class="text-3xl font-semibold tracking-tight text-pretty text-gray-900 sm:text-4xl">Meet our family</h2>
        <p class="mt-6 text-lg/8 text-gray-600">
          Wij zijn een vrolijke familie vol gekkigheid. Hoe blij ben je? Geef een cijfer! Zo houden we alles bij, op ons
          eigen dashboard: Family Desk!
        </p>
        <h3 class="text-xl font-semibold tracking-tight text-pretty text-gray-900 sm:text-xl"><br>
          Ons gemiddelde cijfer is op dit moment een:
          <span class="text-indigo-600">{{ averageCijfer }}</span>
        </h3>
      </div>
      <h2 class="text-3xl font-semibold tracking-tight text-pretty text-gray-900 sm:text-4xl text-center">
        Familieleden
      </h2>
      <div class="border-0 border-solid border-blue-900 rounded-md shadow-xl/30 p-4">
        <ul role="list" class="grid gap-x-8 gap-y-12 sm:grid-cols-2 sm:gap-y-16 xl:col-span-2">
          <li v-for="user in users" :key="user.id">
            <div class="flex items-center gap-x-6">
              <img class="size-35 rounded-full" :src="user.profile_picture" alt="" />
              <div>
                <h3 class="text-base/7 font-semibold tracking-tight text-gray-900">
                  {{ user.name }}
                </h3>
                <p class="text-sm/6 font-semibold text-indigo-600">
                  {{ user.role }}
                </p>
                <p class="text-sm/6 text-gray-900">
                  <span class="text-base/6 font-semibolt text-gray-900">My mood today:</span>
                  <br />
                  {{ user.mood }}
                </p>
                <p class="text-sm/6 font-semibold text-indigo-600">Cijfer: {{ user.cijfer }}</p>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>
