# Monte Carlo simulated European option price

Monte Carlo simulated European option price

## Usage

``` r
mc_price(
  S,
  K,
  r,
  q = 0,
  sigma,
  T,
  n,
  type = c("call", "put"),
  antithetic = TRUE,
  control_variate = TRUE,
  seed = NULL
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

  Number of steps

- type:

  'call' or 'put'

- antithetic:

  Antithetic variance reduction method, TRUE by default

- control_variate:

  Control variate variance reduction method, TRUE by default

- seed:

  Controls randomness for reproducibility

## Value

Option price.

## References

Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*.
McGraw-Hill Education.

## Examples

``` r
mc_price(100, 100, 0.03, 0, 0.2, 0.5, 1000, type = 'call', antithetic = TRUE, control_variate = TRUE)
#> $price
#> [1] 6.556303
#> 
#> $se
#> [1] 0.1333071
#> 
#> $method
#> [1] "MC antithetic + control"
#> 
```
