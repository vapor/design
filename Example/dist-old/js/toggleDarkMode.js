const toggleSwitch = document.querySelector('#theme-switch');

//function that changes the theme, and sets a localStorage variable to track the theme between page loads
function switchTheme(e) {
    if (document.documentElement.classList.contains("dark")) {
        localStorage.setItem('theme', 'light');
        document.documentElement.classList.remove("dark");
    } else {
        localStorage.setItem('theme', 'dark');
        document.documentElement.classList.add("dark");
    }    
}

// listener for changing themes
toggleSwitch.addEventListener('click', switchTheme, false);