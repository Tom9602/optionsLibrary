#' Cox-Ross-Rubinstein binomial option price
#' 
#' @param S Spot price
#' @param K Strike price
#' @param r Risk-free rate (annual, decimal)
#' @param q Dividend yield (annual, decimal, zero by default)
#' @param sigma Volatility (annual, decimal)
#' @param T Time to maturity (years)
#' @param n Number of steps
#' @param type 'call' or 'put'
#' @param american allowing for early exercise
#' @description
#' Calculates option price based on a Cox-Ross-Rubinstein binomial tree.
#' @return Option price.
#' @examples
#' binomial_price(100, 100, 0.03, 0, 0.2, 0.5, 100, 'call', american = FALSE)
#' 
#' @references Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*. McGraw-Hill Education.
#' @export

binomial_price <- function(S, K, r, q = 0, sigma, T, n = 100, type = c('call', 'put'), american = FALSE) {
  type <- match.arg(type)
  h <- T / n
  u <- exp(sigma * sqrt(h))
  d <- exp(-sigma * sqrt(h))
  R <- exp((r - q) * h)
  rn <- (R - d)/(u - d)
  ST <- S * u^(0:n) * d^(n:0)
  if (type == 'call') {
    payoff <- pmax(ST - K, 0)
  } else {
    payoff <- pmax(K- ST, 0)
  }
  discount <- exp(-r * h)
  for (i in n:1) {
    payoff <- discount * (rn * payoff[2:(i+1)] + (1 - rn) * payoff[1:i])
    if (american) {
      Si <- S * u^(0:(i-1)) * d^((i-1):0)
      if (type == 'call') {
        payoff <- pmax(payoff, Si - K)
      } else {
        payoff <- pmax(payoff, K - Si)
      }
    }
  }
  return(as.numeric(payoff))
}