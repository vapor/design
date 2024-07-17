function isScrollable(element) {
    return element.scrollWidth > element.clientWidth;
}

function updateScrollButtonStates(scrollable, leftButton, rightButton) {
    const isAtStart = scrollable.scrollLeft === 0;
    const isAtEnd = scrollable.scrollLeft + scrollable.clientWidth >= scrollable.scrollWidth - 1; // -1 to account for rounding errors

    leftButton.disabled = isAtStart;
    rightButton.disabled = isAtEnd;

    // Optional: Add/remove a class for styling
    leftButton.classList.toggle('disabled', isAtStart);
    rightButton.classList.toggle('disabled', isAtEnd);
}

function updateScrollButtonVisibility(scrollable, buttonGroup) {
    if (isScrollable(scrollable)) {
        buttonGroup.style.display = 'flex';
        const leftButton = buttonGroup.querySelector(".left-scroll-button");
        const rightButton = buttonGroup.querySelector(".right-scroll-button");
        updateScrollButtonStates(scrollable, leftButton, rightButton);
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

            // Update button states after scrolling
            setTimeout(() => {
                const leftButton = buttonGroup.querySelector(".left-scroll-button");
                const rightButton = buttonGroup.querySelector(".right-scroll-button");
                updateScrollButtonStates(scrollable, leftButton, rightButton);
            }, 500); // Adjust timeout to match your scroll behavior duration
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
            const leftButton = buttonGroup.querySelector(".left-scroll-button");
            const rightButton = buttonGroup.querySelector(".right-scroll-button");

            updateScrollButtonVisibility(scrollable, buttonGroup);

            // Add event listeners to buttons
            leftButton.addEventListener("click", scrollToLeft);
            rightButton.addEventListener("click", scrollToRight);

            // Update visibility and button states on scroll
            scrollable.addEventListener('scroll', () => {
                updateScrollButtonStates(scrollable, leftButton, rightButton);
            });

            // Update visibility and button states on window resize
            window.addEventListener('resize', () => {
                updateScrollButtonVisibility(scrollable, buttonGroup);
            });

            // Optional: Update visibility and button states when content changes
            const observer = new MutationObserver(() => {
                updateScrollButtonVisibility(scrollable, buttonGroup);
            });
            observer.observe(scrollable, { childList: true, subtree: true });
        }
    });
}

// Call this function when the DOM is ready
document.addEventListener('DOMContentLoaded', initializeScrollButtons);
