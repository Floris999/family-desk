import { createRouter, createWebHistory } from "vue-router";
import HomeRoute from "./Pages/HomeRoute.vue";
import LoginRoute from "./Pages/LoginRoute.vue";
import RegisterRoute from "./Pages/RegisterRoute.vue";
import SettingsRoute from "./Pages/SettingsRoute.vue";
import WishListRoute from "./Pages/WishListRoute.vue";
import FormWishlistRoute from "./Pages/FormWishlistRoute.vue";
import { useAuthStore } from "@stores/authStore";

const routes = [
  { path: "/", component: HomeRoute },
  { path: "/login", component: LoginRoute },
  { path: "/register", component: RegisterRoute },
  { path: "/settings", component: SettingsRoute },
  { path: "/wishlist", component: WishListRoute },
  { path: "/add-wish", component: FormWishlistRoute },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore();

  if (to.path === "/logout") {
    authStore.isLoggedIn = false;
    alert("Je bent uitgelogd! Kom je snel weer terug?");
    next("/login");
  }
  if (to.path === "/" && !authStore.isLoggedIn) {
    next("/login");
  } else {
    next();
  }
});

export default router;
