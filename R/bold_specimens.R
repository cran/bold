#' Search BOLD for specimens.
#'
#' @template args
#' @template otherargs
#' @param format (character) One of xml, json, tsv (default). tsv format gives
#' back a data.frame object. xml gives back parsed XML as `xml_document`
#' object. 'json' (JavaScript Object Notation) and 'dwc' (Darwin Core Archive)
#' are supported in theory, but the JSON can be malformed, so we don't support
#' that here, and the DWC option actually returns TSV.
#' @param cleanData (logical) If `TRUE`, the cell values containing only duplicated values (ex : "COI-5P|COI-5P|COI-5P") will be reduce to one value ("COI-5P") and empty string will be change to NA. Default: `FALSE`
#'
#' @template missing-taxon
#' @references
#' http://v4.boldsystems.org/index.php/resources/api?type=webservices
#'
#' @examples \dontrun{
#' bold_specimens(taxon='Osmia')
#' bold_specimens(taxon='Osmia', format='xml')
#' bold_specimens(taxon='Osmia', response=TRUE)
#' res <- bold_specimens(taxon='Osmia', format='xml', response=TRUE)
#' res$url
#' res$status_code
#' res$response_headers
#'
#' # More than 1 can be given for all search parameters
#' bold_specimens(taxon=c('Coelioxys','Osmia'))
#'
#' ## curl debugging
#' ### These examples below take a long time, so you can set a timeout so that
#' ### it stops by X sec
#' head(bold_specimens(taxon='Osmia', verbose = TRUE))
#' # head(bold_specimens(geo='Costa Rica', timeout_ms = 6))
#' }
#'
#' @export
bold_specimens <- function(taxon = NULL, ids = NULL, bin = NULL,
                           container = NULL, institutions = NULL,
                           researchers = NULL, geo = NULL, response = FALSE,
                           format = 'tsv', cleanData = FALSE, ...) {

  format <- b_assert_format(format)
  response <- b_assert_logical(response)
  cleanData <- b_assert_logical(cleanData)
  if (!format %in% c('xml', 'tsv')) stop("'format' should be of of 'xml' or 'tsv'.")
  params <- b_pipe_params(
      taxon = taxon,
      geo = geo,
      ids = ids,
      bin = bin,
      container = container,
      institutions = institutions,
      researchers = researchers
    )
  res <- b_GET(query = c(params, format = format),
               api = 'API_Public/specimen', ...)
  if (response) {
    res
  } else {
    b_parse(res, format, cleanData, raise = TRUE)
  }
}
