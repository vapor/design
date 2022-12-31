# Vapor Design

This repo contains all of the materials used for building out Vapor's design across its many sites, built on top of Bootstrap. It contains the reference designs and files from designers in [Reference](/Reference/) and build pipelines and code to generate the necessary files to be included in Vapor's sites. These are automatically deployed to https://design.vapor.codes - hosted on our CDN - and then included in the different sites.

The repo also contains a `VaporDesign` Swift library that includes a number of components for working with [Publish](https://github.com/JohnSundell/Publish) and the design guide, such as a `SiteFooter` and `SiteNavigation` component.

## Running

To build the design files you'll need [NPM](https://www.npmjs.com) installed (you should probably use [nvm](https://github.com/nvm-sh/nvm) to manage this). Then, run:

```bash
npm install && npm run build
```

This compiles the JavaScript and CSS from Sass and copies over any other static files into the Output directory.

To run the demo site, run:

```bash
swift run
npm install && npm start
```

This generates the HTML for the site then copies over the additional files.

> **Warning**
> Currently Publish will empty the `Output` directory before regenerating the files meaning that all the CSS, JS and images will be removed. You **must** run `npm start` or `npm run build` after generating the HTML for the styles to work. Any changes to JS or CSS will automatically be picked up.

Then open the site at http://localhost:8001

## Copyright

All the designs and images in this repository are the copyright of Vapor and QuTheory LLC and not part of Vapor's open source code.