<script setup>
import { useRouter } from "vue-router";
import { ref } from "vue";
import axios from "axios";
import { useAuthStore } from "@stores/authStore";

const form = ref({
    email: "",
    password: "",
});

const errors = ref({});
const router = useRouter();
const authStore = useAuthStore();

const submitForm = async () => {
    try {
        errors.value = {};
        const response = await axios.post("/login", {
            email: form.value.email,
            password: form.value.password,
        });

        authStore.login({
            name: response.data.name,
            email: response.data.email,
        });

        alert("Je bent ingelogd!");
        console.log("AuthStore inhoud:", authStore.$state);
        router.push("/");
    } catch (error) {
        if (error.response && error.response.status === 401) {
            alert("Oeps, er is iets fout gegaan. Controleer je gegevens.");
        } else {
            console.error("Er is een fout opgetreden:", error);
        }
    }
};
</script>

<template>
    <div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
        <div class="sm:mx-auto sm:w-full sm:max-w-sm">
            <img
                class="mx-auto h-10 w-auto"
                src="../../../public/family.png"
                alt="Your Company"
            />
            <h2
                class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900"
            >
                Hi Familielid!
            </h2>
        </div>

        <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form @submit.prevent="submitForm" class="space-y-6">
                <div>
                    <label
                        for="email"
                        class="block text-sm/6 font-medium text-gray-900"
                        >E-mailadres</label
                    >
                    <div class="mt-2">
                        <input
                            v-model="form.email"
                            type="email"
                            name="email"
                            id="email"
                            autocomplete="email"
                            required
                            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
                        />
                    </div>
                </div>

                <div>
                    <label
                        for="password"
                        class="block text-sm/6 font-medium text-gray-900"
                        >Wachtwoord</label
                    >
                    <div class="mt-2">
                        <input
                            v-model="form.password"
                            type="password"
                            name="password"
                            id="password"
                            autocomplete="current-password"
                            required
                            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
                        />
                    </div>
                </div>

                <div>
                    <button
                        type="submit"
                        class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                    >
                        Inloggen
                    </button>
                </div>
            </form>

            <p class="mt-10 text-center text-sm/6 text-gray-500">
                Nog geen lid?
                <a
                    href="/register"
                    class="font-semibold text-indigo-600 hover:text-indigo-500"
                    >Maak nu een account</a
                >
            </p>
        </div>
    </div>
</template>
