// Import our custom CSS
import '../scss/main.scss'

// Import all of Bootstrap's JS
import * as bootstrap from 'bootstrap'

import './startSyntaxHighlighting.js'
import './toggleDarkMode.js'
import './styleHelpers.js'

// Functions to export to HTML
require('./copyLink.js');
require('./styleHelpers.js');
export * from './copyLink.js'
export * from './styleHelpers.js'