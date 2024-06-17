const toggleSwitch = document.querySelector('#theme-switch');

//function that changes the theme, and sets a localStorage variable to track the theme between page loads
function switchTheme(e) {
    e.preventDefault();
    if (document.documentElement.classList.contains("dark")) {
        localStorage.setItem('theme', 'light');
        document.documentElement.classList.remove("dark");
        var metaThemeColor = document.querySelector("meta[name=theme-color]");
        metaThemeColor.setAttribute("content", "#ffffff");
    } else {
        localStorage.setItem('theme', 'dark');
        document.documentElement.classList.add("dark");
        var metaThemeColor = document.querySelector("meta[name=theme-color]");
        metaThemeColor.setAttribute("content", "#141416");
    }
}

// listener for changing themes
toggleSwitch.addEventListener('click', switchTheme, false);
