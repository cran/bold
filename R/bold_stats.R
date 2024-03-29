#' Get BOLD stats
#'
#' @inheritParams bold_specimens
#' @param dataType (character) one of "drill_down"(default) or "overview".
#' "drill_down": a detailed summary of information which provides record counts
#' by BINs, Countries, Storing Institutions, Orders, Families, Genus, Species.
#' "overview": the total record counts of BINs, Countries, Storing Institutions,
#' Orders, Families, Genus, Species. The record counts include all gene markers, not only COI. To see the drill down of markers use \code{\link{bold_tax_id2}} with "stats" as `dataTypes`.
#' @param simplify (logical) whether the returned list should be simplified to a data.frame. See Details.
#'
#' @return By default, returns a nested list with the number of total records, the number of records with a species name, then for each of bins, countries, depositories, order, family, genus and species, the total count and the drill down of the records by up to 10 entities of that category. If `simplify` is set to TRUE, returns a list of length 2 : the overview data (number of total records, the number of records with a species name, and the total counts) simplified as a data.frame of 1 row and 9 columns and the drill_down data simplified to a one level list of data.frame. When `dataType` is set to "overview", returns a nested list with the number of total records, the number of records with a species name, and the total count for each of bins, countries, depositories, order, family, genus and species. If `simplify` is set to TRUE, returns a data.frame of 1 row and 9 columns.
#'
#' @references
#' http://v4.boldsystems.org/index.php/resources/api?type=webservices
#'
#' @examples \dontrun{
#' x <- bold_stats(taxon='Osmia')
#' x$total_records
#' x$records_with_species_name
#' x$bins
#' x$countries
#' x$depositories
#' x$order
#' x$family
#' x$genus
#' x$species
#'
#' # just get all counts
#' lapply(Filter(is.list, x), `[[`, "count")
#'
#' bold_stats(taxon='Osmia', dataType = "overview", simplified = TRUE)
#'
#' x <- bold_stats(taxon='Osmia', simplified = TRUE)
#' x$overview
#' x$drill_down
#'
#' res <- bold_stats(taxon='Osmia', response=TRUE)
#' res$url
#' res$status_code
#' res$response_headers
#'
#' # More than 1 can be given for all search parameters
# bold_stats(taxon=c('Coelioxys','Osmia'))
#'
#' ## curl debugging
#' ### These examples below take a long time, so you can set a timeout so that
#' ### it stops by X sec
#' bold_stats(taxon='Osmia', verbose = TRUE)
#' # bold_stats(geo='Costa Rica', timeout_ms = 6)
#' }
#'
#' @export
bold_stats <- function(taxon = NULL, ids = NULL, bin = NULL,
  container = NULL, institutions = NULL, researchers = NULL, geo = NULL,
  dataType = "drill_down", response = FALSE, simplify = FALSE, ...) {
  b_assert(dataType, "character", check.length = 1L)
  response <- b_assert_logical(response)
  dataType <- tolower(dataType)
  b_validate(dataType, c("overview", "drill_down"), "dataType")
  params <- b_pipe_params(taxon = taxon, geo = geo,
                          ids = ids, bin = bin,
                          container = container,
                          institutions = institutions,
                          researchers = researchers)
  res <- b_GET(query = c(params, dataType = dataType, format = 'json'),
               api = 'API_Public/stats', ...)
  if (response) {
    res
  } else {
    out <- b_parse(res, format = "json")
    if (simplify) {
      b_simplify_stats(out, dataType = dataType)
    } else {
      out
    }
  }
}
b_simplify_stats <- function(x, dataType) {
  if (dataType == "drill_down") {
    n <- which(vapply(x, inherits, NA, "integer"))
    ov <- vapply(x[-n], `[[`, 0L, "count")
    ov <- as.data.frame(c(x[n],ov))
    dd <- lapply(x[-n], \(x) {
      y <- x$drill_down
      i <- 0
      while (!is.data.frame(y) && i < 5) {
        y <- y[[1]]
        i <- i + 1
      }
      y
    })
    list(overview = ov, drill_down = dd)
  } else {
    structure(as.list(vapply(x, as.integer, 0L)), class = "data.frame", row.names = 1L)
  }
}
