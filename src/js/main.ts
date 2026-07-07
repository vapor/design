// Import our custom CSS
import '../scss/main.scss'

// Import all of Bootstrap's JS (side-effect import: registers its data-api
// click handlers for dropdowns, collapses, etc.)
import 'bootstrap'

import './startSyntaxHighlighting'
import './toggleDarkMode'
import './themePicker'
import './mobileNav'
import './pickerDropdown'
import './styleHelpers'
import './shareLinks'
import './languageSuggestion'

// Functions to export to HTML — exposed on the `Vapor` global via webpack's
// output.library config. Re-exporting also evaluates copyLink, wiring its
// copy-link buttons. (styleHelpers is a side-effect module with no exports, so
// it's imported above rather than re-exported here.)
export * from './copyLink'
