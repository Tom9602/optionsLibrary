# optionsLibrary

A simple R package I made for fun for pricing European options using:

- Black-Scholes model

- Cox-Ross-Rubinstein binomial tree

- Monte Carlo simulation

- Option Greeks


Refer to the vignette for usage demonstration and an example:

- Click [HERE!](https://tom9602.github.io/optionsLibrary/articles/option_pricing_tutorial.html) for the online vignette

- Or in R, run the command: `browseVignettes('optionsLibrary')`



## Installation
In R, run the following:
```r
# install devtools if not yet downloaded
install.packages('devtools')

# install the package from GitHub
devtools::install_github('Tom9602/optionsLibrary')

# load the package
library(optionsLibrary)
```