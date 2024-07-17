function isScrollable(element) {
    return element.scrollWidth > element.clientWidth;
}

function updateScrollButtonVisibility(scrollable, buttonGroup) {
    if (isScrollable(scrollable)) {
        buttonGroup.style.display = 'flex';
    } else {
        buttonGroup.style.display = 'none';
    }
}

function scroll(direction) {
    return function (event) {
        const buttonGroup = event.target.closest(".scroll-button-group");
        const scrollableID = buttonGroup.getAttribute("data-scrollable");
        const scrollable = document.getElementById(scrollableID);
        const cardWidth = scrollable.querySelector(".card").offsetWidth + 32;

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

function initializeScrollButtons() {
    document.querySelectorAll(".scroll-button-group").forEach(buttonGroup => {
        const scrollableID = buttonGroup.getAttribute("data-scrollable");
        const scrollable = document.getElementById(scrollableID);

        if (scrollable) {
            updateScrollButtonVisibility(scrollable, buttonGroup);

            // Add event listeners to buttons
            buttonGroup.querySelector(".left-scroll-button").addEventListener("click", scrollToLeft);
            buttonGroup.querySelector(".right-scroll-button").addEventListener("click", scrollToRight);

            // Update visibility on window resize
            window.addEventListener('resize', () => updateScrollButtonVisibility(scrollable, buttonGroup));

            // Optional: Update visibility when content changes
            // You might need to call this function manually if you dynamically add/remove content
            const observer = new MutationObserver(() => updateScrollButtonVisibility(scrollable, buttonGroup));
            observer.observe(scrollable, { childList: true, subtree: true });
        }
    });
}

// Call this function when the DOM is ready
document.addEventListener('DOMContentLoaded', initializeScrollButtons);
