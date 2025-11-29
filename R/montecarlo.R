#' Monte Carlo simulated European option price
#' 
#' @importFrom stats rnorm sd
#' @param S Spot price
#' @param K Strike price
#' @param r Risk-free rate (annual, decimal)
#' @param q Dividend yield (annual, decimal, zero by default)
#' @param sigma Volatility (annual, decimal)
#' @param T Time to maturity (years)
#' @param n Number of steps
#' @param type 'call' or 'put'
#' @param antithetic Antithetic variance reduction method, TRUE by default
#' @param control_variate Control variate variance reduction method, TRUE by default
#' @param seed Controls randomness for reproducibility
#' @return Option price.
#' @examples
#' mc_price(100, 100, 0.03, 0, 0.2, 0.5, 1000, type = 'call', antithetic = TRUE, control_variate = TRUE)
#' 
#' @references Das, S., & Sundaram, R. (2015) *Derivatives: Principles and Practice*. McGraw-Hill Education.
#' @export

mc_price <- function(S, K, r, q = 0, sigma, T, n, type = c('call', 'put'), antithetic = TRUE, control_variate = TRUE, seed = NULL) {
  type <- match.arg(type)
  if (!is.null(seed)) set.seed(seed)
  
  if (antithetic) {
    z <- rnorm(ceiling(n / 2))
    z_full <- c(z, -z)
    z_full <- z_full[1:n]
  } else {
    z_full <- rnorm(n)
  }
  
  ST <- S * exp((r - q - 0.5*sigma^2) * T + sigma * sqrt(T) * z_full)
  if (type == 'call') {
    payoff <- pmax(ST - K, 0)
  } else {
    payoff <- pmax(K - ST, 0)
  }
  
  discount_payoff <- exp(-r * T) * payoff
  price <- mean(discount_payoff)
  se <- sd(discount_payoff) / sqrt(n)
  
  if (control_variate) {
    control <- ST * exp(-r * T)
    cov <- cov(discount_payoff, control)
    var <- var(control)
    w <- ifelse(var == 0, 0, cov / var)
    adjusted <- discount_payoff - w * (control - S * exp(-q * T))
    price_cv <- mean(adjusted)
    se_cv <- sd(adjusted) / sqrt(n)
    return(list(price = price_cv, se = se_cv, method = ifelse(antithetic, 'MC antithetic + control', 'MC control')))
  } else {
    return(list(price = price, se = se, method = ifelse(antithetic, 'MC antithetic', 'MC normal')))
  }
}