// Apply the saved colour scheme before first paint to avoid a flash.
// Matches the shared toggleDarkMode.js in main.js: a `.dark` class on <html>,
// persisted under the "theme" key ("system" falls back to the OS setting).
//
// Loaded as an external <script> from the shared <head> (synchronous, so it
// still runs before the first paint) rather than inline, so the
// Content-Security-Policy needs no 'unsafe-inline' for scripts.
(function () {
    try {
        var t = localStorage.getItem("theme");
        if (!t || t === "system") {
            t = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
        }
        if (t === "dark") {
            document.documentElement.classList.add("dark");
            var m = document.querySelector('meta[name="theme-color"]');
            if (m) m.setAttribute("content", "#141416");
        }
    } catch (e) {}
})();
