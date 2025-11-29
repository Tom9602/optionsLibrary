# Black-Scholes option Greeks

Determines option Greeks for a given set of option characteristics.

## Usage

``` r
bs_greeks(S, K, r, q = 0, sigma, T, type = c("call", "put"))
```

## Arguments

- S:

  Spot price

- K:

  Strike price

- r:

  Risk-free rate (annual, decimal)

- q:

  Dividend yield (annual, decimal, zero by default)

- sigma:

  Volatility (annual, decimal)

- T:

  Time to maturity (years)

- type:

  'call' or 'put'

## Value

List of option Greeks.

## References

Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*.
McGraw-Hill Education.

## Examples

``` r
bs_greeks(100, 100, 0.03, 0, 0.2, 0.5, 'call')
#> $Delta
#> [1] 0.5701581
#> 
#> $Gamma
#> [1] 0.02777213
#> 
#> $Theta
#> [1] -7.07377
#> 
#> $Vega
#> [1] 27.77213
#> 
#> $Rho
#> [1] 25.32239
#> 
```
