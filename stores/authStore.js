import { defineStore } from "pinia";

export const useAuthStore = defineStore("auth", {
  state: () => ({
    user: null,
    isLoggedIn: false,
    wishes: [],
  }),
  actions: {
    login(userData) {
      this.user = userData;
      this.isLoggedIn = true;
      this.wishes = userData.wishes || [];
    },
    logout() {
      this.user = null;
      this.isLoggedIn = false;
      this.wishes = [];
    },
    addWish(wish) {
      this.wishes.push({
        title: wish.title,
        description: wish.description,
      });
    },
  },
  persist: {
    enabled: true,
    strategies: [
      {
        key: "auth",
        storage: localStorage,
      },
    ],
  },
});
