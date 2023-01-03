export function toggleDocumentationDropdown() {
    const myDropdown = document.getElementById('documentation-navbar-chevron');
    const dropdownLink = document.getElementById('documentation-dropdown-link');
    if (dropdownLink.classList.contains('show')) {
        myDropdown.dataset.shown = true;
    } else {
        myDropdown.dataset.shown = false;
    }
}