## 1.0.2
* BUG FIXES
    * Fix standalone usage
    
## 1.0.1

* REMOVALS
    * Outdated param `countries` was renamed to `iso_to` in `@cli.bank`
* BUG FIXES
    * Fix `instance variable is not initialized` warning
* ENHANCEMENTS
    * Add pagination to some endpoints. Example: `@cli.rates{ |response| puts response.data }`
