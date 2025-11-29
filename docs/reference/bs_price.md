# Black-Scholes European option price

Calculates option price based on Black-Scholes formula.

## Usage

``` r
bs_price(S, K, r, q = 0, sigma, T, type = c("call", "put"))
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

Option price.

## References

Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*.
McGraw-Hill Education.

## Examples

``` r
bs_price(100, 100, 0.03, 0, 0.2, 0.5, 'call')
#> [1] 6.371028
```
