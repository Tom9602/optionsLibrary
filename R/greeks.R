#' Black-Scholes option Greeks
#' 
#' @importFrom stats pnorm dnorm
#' @param S Spot price
#' @param K Strike price
#' @param r Risk-free rate (annual, decimal)
#' @param q Dividend yield (annual, decimal, zero by default)
#' @param sigma Volatility (annual, decimal)
#' @param T Time to maturity (years)
#' @param type 'call' or 'put'
#' 
#' @return List of option Greeks.
#' @description
#' Determines option Greeks for a given set of option characteristics.
#' @references Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*. McGraw-Hill Education.
#' @examples
#' bs_greeks(100, 100, 0.03, 0, 0.2, 0.5, 'call')
#' 
#' @export

bs_greeks <- function(S, K, r, q = 0, sigma, T, type = c('call', 'put')) {
  type <- match.arg(type)
  if (T <= 0) {
    stop('Time to maturity (T) must be > 0.')
  }
  d1 <- (log(S / K) + (r - q + 0.5*sigma^2) * T) / (sigma * sqrt(T))
  d2 <- d1 - sigma * sqrt(T)
  pdf_d1 <- dnorm(d1)
  if (type == 'call') {
    delta <- pnorm(d1)
    gamma <- pdf_d1 / (sigma * S * sqrt(T))
    theta <- -(sigma * S * pdf_d1) / (2 * sqrt(T)) - r * exp(-r * T) * K * pnorm(d2)
    vega <- sqrt(T) * S * pdf_d1
    rho <- exp(-r * T) * K * pnorm(d2) * T
  }
  else {
    delta <- pnorm(d1) - 1
    gamma <- pdf_d1 / (sigma * S * sqrt(T))
    theta <- -(sigma * S * dnorm(-d1)) / (2 * sqrt(T)) + r * exp(-r * T) * K * pnorm(-d2)
    vega <- sqrt(T) * S * pdf_d1
    rho <- -exp(-r * T) * K * pnorm(-d2) * T
  }
  return(list(
    Delta = delta,
    Gamma = gamma,
    Theta = theta,
    Vega = vega,
    Rho = rho
  ))
}