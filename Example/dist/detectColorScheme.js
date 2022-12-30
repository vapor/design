(()=>{function t(){var e="light";if(localStorage.getItem("theme"))localStorage.getItem("theme")=="dark"&&(e="dark");else if(window.matchMedia)window.matchMedia("(prefers-color-scheme: dark)").matches&&(e="dark");else return!1;e=="dark"&&document.documentElement.classList.add("dark")}t();})();
//# sourceMappingURL=detectColorScheme.js.map
