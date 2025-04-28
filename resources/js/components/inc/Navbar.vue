<script setup>
import { onMounted } from "vue";
import { useAuthStore } from "@stores/authStore";

const authStore = useAuthStore();

const userPicture = authStore.user?.profile_picture || "'storage/profile_pictures/family.png'";
</script>

<template>
  <!--<router-link to="/test">Take me to Test page</router-link>-->
  <nav class="bg-gray-800">
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="flex h-16 items-center justify-between">
        <div class="flex items-center">
          <!-- <div class="shrink-0">
            <img
              class="size-8"
              src="https://tailwindcss.com/plus-assets/img/logos/mark.svg?color=indigo&shade=500"
              alt="Your Company"
            />
          </div> -->
          <div class="hidden md:block">
            <div class="flex items-baseline space-x-4">
              <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
              <router-link
                class="rounded-md bg-gray-900 px-3 py-2 text-sm font-medium text-white"
                aria-current="page"
                to="/"
              >
                Home
              </router-link>
              <router-link
                class="rounded-md bg-gray-900 px-3 py-2 text-sm font-medium text-white"
                aria-current="page"
                to="/wishlist"
              >
                Wishlist
              </router-link>
            </div>
          </div>
        </div>
        <div class="hidden md:block">
          <div class="ml-4 flex items-center md:ml-6">
            <!-- <button
                            type="button"
                            class="relative rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
                        >
                            <span class="absolute -inset-1.5"></span>
                            <span class="sr-only">View notifications</span>
                            <svg
                                class="size-6"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                aria-hidden="true"
                                data-slot="icon"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M14.857 17.082a23.848 23.848 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0"
                                />
                            </svg>
                        </button> -->

            <!-- Profile dropdown -->
            <div class="relative ml-3">
              <div class="flex gap-x-6">
                <router-link
                  class="rounded-md bg-gray-900 px-3 py-2 text-sm font-medium text-white cursor-pointer"
                  aria-current="page"
                  to="/settings"
                >
                  <button
                    type="button"
                    class="relative flex max-w-xs items-center rounded-full bg-gray-800 text-sm cursor-pointer"
                    id="user-menu-button"
                  >
                    <img class="size-8 rounded-full" :src="userPicture" alt="" />
                  </button>
                </router-link>
                <router-link
                  class="rounded-md bg-gray-900 px-3 py-3 text-sm font-medium text-white"
                  aria-current="page"
                  to="/logout"
                >
                  Logout
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Mobile menu, show/hide based on menu state. -->
    <div class="md:hidden" id="mobile-menu">
      <div class="space-y-1 px-2 pt-2 pb-3 sm:px-3">
        <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
        <a
          href="/"
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
          aria-current="page"
        >
          Home
        </a>
        <a
          href="/wishlist"
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
          aria-current="page"
        >
          Wishlist
        </a>
        <a
          href="/settings"
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
        >
          Settings
        </a>
        <router-link
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
          to="/logout"
        >
          Logout
        </router-link>
      </div>
    </div>
  </nav>
</template>
