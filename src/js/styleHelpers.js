document.addEventListener('DOMContentLoaded', function() {
    const dropdownLink = document.getElementById('documentation-dropdown-link');
    const chevronIcon = document.getElementById('documentation-navbar-chevron');

    dropdownLink.addEventListener('show.bs.dropdown', function() {
        chevronIcon.dataset.shown = 'true';
    });

    dropdownLink.addEventListener('hide.bs.dropdown', function() {
        chevronIcon.dataset.shown = 'false';
    });
});
