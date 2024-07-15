function scroll(direction) {
    return function (event) {
        const buttonGroup = event.target.closest(".scroll-button-group");
        const scrollableID = buttonGroup.getAttribute("data-scrollable");
        const scrollable = document.getElementById(scrollableID);

        const cardWidth = scrollable.querySelector(".card").offsetWidth + 32;

        console.log(cardWidth);

        if (scrollable) {
            scrollable.scrollBy({
                top: 0,
                left: direction * cardWidth,
                behavior: 'smooth'
            });
        }
    };
}

const scrollToRight = scroll(1);
const scrollToLeft = scroll(-1);

document.querySelectorAll(".left-scroll-button").forEach(button => {
    button.addEventListener("click", scrollToLeft);
});

document.querySelectorAll(".right-scroll-button").forEach(button => {
    button.addEventListener("click", scrollToRight);
});
