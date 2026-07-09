(() => {
    try {
        let t = window.localStorage.getItem("theme");
        if (!t || t === "system") {
            t = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
        }
        if (t === "dark") {
            document.documentElement.classList.add("dark");
            document.querySelector('meta[name="theme-color"]')?.setAttribute("content", "#141416");
        }
    } catch (_e) {}
})();
