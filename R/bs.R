#' Black-Scholes European option price

#' @importFrom stats pnorm
#' @param S Spot price
#' @param K Strike price
#' @param r Risk-free rate (annual, decimal)
#' @param q Dividend yield (annual, decimal, zero by default)
#' @param sigma Volatility (annual, decimal)
#' @param T Time to maturity (years)
#' @param type 'call' or 'put'
#' @return Option price.
#' @description
#' Calculates option price based on Black-Scholes formula.
#' @references Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*. McGraw-Hill Education.
#' 
#' @examples
#' bs_price(100, 100, 0.03, 0, 0.2, 0.5, 'call')
#' 
#' @export

bs_price <- function(S, K, r, q = 0, sigma, T, type=c('call', 'put')) {
  type <- match.arg(type)
  if (T <= 0) {
    if (type == 'call') return(pmax(S - K, 0))
    else return(pmax(K - S, 0))
  }
  d1 <- (log(S / K) + (r - q + 0.5*sigma^2) * T) / (sigma * sqrt(T))
  d2 <- d1 - sigma * sqrt(T)
  if (type == 'call') {
    price <- S * exp(-q * T) * pnorm(d1) - K * exp(-r * T) * pnorm(d2)
  }
  else {
    price <- K * exp(-r * T) * pnorm(-d2) - S * exp(-q * T) * pnorm(-d1)
  }
  return(price)
}