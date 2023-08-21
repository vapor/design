window.onscroll = function () { scrollFunction() };

function scrollFunction() {
    const navbar = document.querySelector(".navbar");
    if (document.body.scrollTop > 1200 || document.documentElement.scrollTop > 1200) {
        navbar.style.top = "0";
    } else {
        navbar.style.top = "-80px";
    }
}
