# Vapor Design

This repo contains all of the materials used for building out Vapor's design across its many sites. It contains the reference designs and files from designers in [Reference](/Reference/) and build pipelines and code to generate the necessary files to be included in Vapor's sites. These are automatically deployed to design.vapor.codes - hosted on our CDN - and then included in the different sites.

There is an example site in [Example](/Example/) to show you how it's used.

## Running

To build the design files you'll need [Sass](https://sass-lang.com/) installed:

```bash
brew install sass/sass/sass
```

Then you can build and watch the code with:

```bash
sass --watch src/scss/main.scss .dist/style.css
```

### Running the demo site

To run the demo site do:

```bash
sass --watch src/scss/main.scss Example/dist/style.css
```

Then start a web server to view the file:

```bash
python -m http.server 9000 --directory Example/
```

Then open the site at http://localhost:9000

## Copyright

All the designs and images in this repository are the copyright of Vapor and QuTheory LLC and not part of Vapor's open source code.