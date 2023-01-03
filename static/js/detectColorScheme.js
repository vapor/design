// Work out the currently preferred color scheme
function detectColorScheme() {
    // Default to light
    var theme = "light";

    // Check local storage
    if (localStorage.getItem("theme")) {
        if (localStorage.getItem("theme") == "dark") {
            theme = "dark";
        }
    // No setting in local storage, work it out from the OS setting
    } else if (!window.matchMedia) {
        // matchMedia method not supported
        return false;
    } else if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
        // OS theme setting detected as dark
        theme = "dark";
    }

    // Dark theme preferred, set document with a correct class
    if (theme=="dark") {
        document.documentElement.classList.add("dark");
        var metaThemeColor = document.querySelector("meta[name=theme-color]");
        metaThemeColor.setAttribute("content", "#141416");
    }
}
detectColorScheme();