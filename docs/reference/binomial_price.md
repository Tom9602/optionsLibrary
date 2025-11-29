# Cox-Ross-Rubinstein binomial option price

Calculates option price based on a Cox-Ross-Rubinstein binomial tree.

## Usage

``` r
binomial_price(
  S,
  K,
  r,
  q = 0,
  sigma,
  T,
  n = 100,
  type = c("call", "put"),
  american = FALSE
)
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

- n:

  number of steps

- type:

  'call' or 'put'

- american:

  allowing for early exercise

## Value

Option price.

## References

Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*.
McGraw-Hill Education.

## Examples

``` r
binomial_price(100, 100, 0.03, 0, 0.2, 0.5, 100, 'call', american = FALSE)
#> [1] 6.35698
```
