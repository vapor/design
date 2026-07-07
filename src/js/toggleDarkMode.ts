const toggleSwitch = document.querySelector('#theme-switch');

//function that changes the theme, and sets a localStorage variable to track the theme between page loads
function switchTheme(e: Event) {
    e.preventDefault();
    if (document.documentElement.classList.contains("dark")) {
        localStorage.setItem('theme', 'light');
        document.documentElement.classList.remove("dark");
        const metaThemeColor = document.querySelector("meta[name=theme-color]");
        metaThemeColor?.setAttribute("content", "#ffffff");
    } else {
        localStorage.setItem('theme', 'dark');
        document.documentElement.classList.add("dark");
        const metaThemeColor = document.querySelector("meta[name=theme-color]");
        metaThemeColor?.setAttribute("content", "#141416");
    }
}

// listener for changing themes
//
// Backwards compatibility: the legacy #theme-switch toggle has been replaced by
// the Light/Dark/System picker (see themePicker.js + SiteNavigation). Sites that
// haven't rebuilt against the new design package yet still render #theme-switch,
// so keep handling it — but guard for its absence on updated sites (where this
// becomes a no-op). Both paths share the same localStorage "theme" key and the
// `.dark` class, so they interoperate during the rollout window.
if (toggleSwitch) {
    toggleSwitch.addEventListener('click', switchTheme, false);
}
