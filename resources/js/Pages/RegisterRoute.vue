<!-- filepath: resources/js/Pages/RegisterRoute.vue -->
<script setup>
import { useRouter } from "vue-router";
import { ref } from "vue";
import axios from "axios";

const form = ref({
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
});

const errors = ref({});
const router = useRouter();

const submitForm = async () => {
    try {
        errors.value = {};

        const response = await axios.post("/register", {
            name: form.value.name,
            email: form.value.email,
            password: form.value.password,
            password_confirmation: form.value.confirmPassword,
        });

        console.log("Gebruiker geregistreerd:", response.data);

        // Redirect naar de homepagina met Vue-router
        alert(
            "Registratie succesvol! Je wordt doorgestuurd naar de homepagina."
        );
        router.push("/");
    } catch (error) {
        if (error.response && error.response.data.errors) {
            errors.value = error.response.data.errors;
        } else {
            console.error("Er is een fout opgetreden:", error);
        }
    }
};
</script>

<template>
    <section class="bg-gray-50 dark:bg-gray-900">
        <div
            class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0"
        >
            <div
                class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700"
            >
                <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
                    <h1
                        class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white"
                    >
                        Maak een account
                    </h1>
                    <form
                        @submit.prevent="submitForm"
                        class="space-y-4 md:space-y-6"
                    >
                        <div>
                            <label
                                for="name"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                >Naam</label
                            >
                            <input
                                v-model="form.name"
                                type="text"
                                name="name"
                                id="name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="John Doe"
                                required
                            />
                            <p v-if="errors.name" class="text-red-500 text-sm">
                                {{ errors.name[0] }}
                            </p>
                        </div>
                        <div>
                            <label
                                for="email"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                >E-mail</label
                            >
                            <input
                                v-model="form.email"
                                type="email"
                                name="email"
                                id="email"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="name@company.com"
                                required
                            />
                            <p v-if="errors.email" class="text-red-500 text-sm">
                                {{ errors.email[0] }}
                            </p>
                        </div>
                        <div>
                            <label
                                for="password"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                >Wachtwoord</label
                            >
                            <input
                                v-model="form.password"
                                type="password"
                                name="password"
                                id="password"
                                placeholder="••••••••"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                required
                            />
                            <p
                                v-if="errors.password"
                                class="text-red-500 text-sm"
                            >
                                {{ errors.password[0] }}
                            </p>
                        </div>
                        <div>
                            <label
                                for="confirmPassword"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                >Bevestig wachtwoord</label
                            >
                            <input
                                v-model="form.confirmPassword"
                                type="password"
                                name="confirmPassword"
                                id="confirmPassword"
                                placeholder="••••••••"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                required
                            />
                        </div>
                        <button
                            type="submit"
                            class="w-full text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                        >
                            Account aanmaken
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</template>
