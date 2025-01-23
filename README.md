
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Birds of Western Palearctic <img src="figures/readme/compendium-sticker.png" align="right" style="float:right; height:120px;"/>

<!-- badges: start -->

![Compendium](https://img.shields.io/badge/Project-Compendium-6666ff?logo=r)
[![Static
Badge](https://img.shields.io/badge/Repo_status-Active-blue)](https://www.repostatus.org/#active)
![Lifecycle
Maturing](https://img.shields.io/badge/Lifecycle-Maturing-007EC6)
[![License: GPL (\>=
2)](https://img.shields.io/badge/License-GPL%20%28%3E%3D%202%29-blue.svg)](https://choosealicense.com/licenses/gpl-2.0/)
<!-- badges: end -->

<p align="left">
• <a href="#overview">Overview</a><br> • <a href="#data-sources">Data
sources</a><br> • <a href="#workflow">Workflow</a><br> •
<a href="#content">Content</a><br> •
<a href="#installation">Installation</a><br> •
<a href="#usage">Usage</a><br> • <a href="#citation">Citation</a><br> •
<a href="#contributing">Contributing</a><br> •
<a href="#acknowledgments">Acknowledgments</a><br> •
<a href="#references">References</a>
</p>

## Overview

This repository is structured as a research compendium and shares the
material used to…

## Data sources

This project uses the following databases:

| Database                                | Usage                            | Reference                     |                                          Link                                          |
|:----------------------------------------|:---------------------------------|:------------------------------|:--------------------------------------------------------------------------------------:|
| WWF Terrestrial Ecoregions of the World | Create Western Palearctic region | Olson *et al.* (2001)         | [link](https://www.worldwildlife.org/publications/terrestrial-ecoregions-of-the-world) |
| Natural Earth                           | Create Western Palearctic region | None                          |                        [link](https://www.naturalearthdata.com)                        |
| BirdLife                                | Get bird species distribution    | BirdLife International (2023) |                [link](https://datazone.birdlife.org/species/requestdis)                |

## Workflow

This is a work in progress…

## Content

This repository is structured as follow:

- [`DESCRIPTION`](https://github.com/frbcesab/birdlife-wp/tree/main/DESCRIPTION):
  contains project metadata (authors, date, dependencies, etc.)

- [`make.R`](https://github.com/frbcesab/birdlife-wp/tree/main/make.R):
  main R script to run the entire project

- [`R/`](https://github.com/frbcesab/birdlife-wp/tree/main/R): contains
  R functions developed especially for this project

- **{{ LIST ADDITIONAL FILES/FOLDER }}**

## Installation

To install this compendium:

- [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)
  this repository using the GitHub interface.
- [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
  your fork using `git clone fork-url` (replace `fork-url` by the URL of
  your fork). Alternatively, open [RStudio
  IDE](https://posit.co/products/open-source/rstudio/) and create a New
  Project from Version Control.

## Usage

Launch the
[`make.R`](https://github.com/frbcesab/birdlife-wp/tree/main/make.R)
file with:

``` r
source("make.R")
```

**Notes**

- All required packages listed in the `DESCRIPTION` file will be
  installed (if necessary)
- All required packages and R functions will be loaded
- Some analyses listed in the `make.R` might take time

## Citation

Please use the following citation:

> Casajus N & Barnagaud JY (2025) Geographical characterics of birds of
> Western Palearctic. URL: <https://github.com/frbcesab/birdlife-wp/>.

## Contributing

All types of contributions are encouraged and valued. For more
information, check out our [Contributor
Guidelines](https://github.com/frbcesab/birdlife-wp/blob/main/CONTRIBUTING.md).

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Acknowledgments

This project has been developed for the
[FRB-CESAB](https://www.fondationbiodiversite.fr/en/about-the-foundation/le-cesab/)
research group
[Acoucene](https://www.fondationbiodiversite.fr/en/the-frb-in-action/programs-and-projects/le-cesab/acoucene/)
that aims to model and project the impacts of the anthropocene on
soundscapes with birds as an acoustic ecological indicator.

## References

BirdLife International and Handbook of the Birds of the World (2023)
Bird species distribution maps of the world. Version 2023-1. Available
at: <http://datazone.birdlife.org/species/requestdis>. Accessed on
\[22/03/2024\].

Olson DM, Dinerstein E, Wikramanayake ED *et al.* (2001) Terrestrial
ecoregions of the World: A new map of life on Earth. **Bioscience**, 51,
933-938. DOI:
[10.1641/0006-3568(2001)051\[0933:TEOTWA\]2.0.CO;2](https://doi.org/10.1641/0006-3568(2001)051%5B0933:TEOTWA%5D2.0.CO;2).
