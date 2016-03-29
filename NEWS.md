bold 0.3.5
===============

### MINOR IMPROVEMENTS

* Added more tests to the test suite (#28)

### BUG FIXES

* Fixed a bug in an internal data parser (#27)

bold 0.3.4
===============

### NEW FEATURES

* Added a code of conduct

### MINOR IMPROVEMENTS

* Switched to `xml2` from `XML` as the XML parser for this package (#26)
* Fixes to `bold_trace()` to create dir and tar file when it doesn't
already exist

### BUG FIXES

* Fixed odd problem where sometimes resulting data from HTTP request
was garbled on `content(x, "text")`, so now using `rawToChar(content(x))`,
which works (#24)


bold 0.3.0
===============

### MINOR IMPROVEMENTS

* Explicitly import non-base R functions (#22)
* Better package level manual file


bold 0.2.6
===============

### MINOR IMPROVEMENTS

* `sangerseqR` package now in Suggests for reading trace files, and is only used in `bold_trace()`
function.
* General code tidying, reduction of code duplication.
* `bold_trace()` gains two new parameters: `overwrite` to choose whether to overwrite an existing
file of the same name or not, `progress` to show a progress bar for downloading or not.
* `bold_trace()` gains a print method to show a tidy summary of the trace file downloaded.

### BUG FIXES

* Fixed similar bugs in `bold_tax_name()` (#17) and `bold_tax_id()` (#18) in which species that were missing from the BOLD database returned empty arrays but 200 status codes. Parsing those as failed attempts now. Also fixes problem in taxize in `bold_search()` that use these two functions.

bold 0.2.0
===============

### NEW FEATURES

* Package gains two new functions for working with the BOLD taxonomy APIs: `bold_tax_name()` and `bold_tax_id()`, which search for taxonomic data from BOLD using either names or BOLD identifiers, respectively. (#11)
* Two new packages in Imports: `jsonlite` and `reshape`.

### MINOR IMPROVEMENTS

* Added new taxonomy API functions to the vignette (#14)
* Added reference URLS to all function doc files to allow easy reference for the appropriate API docs.
* `callopts` parameter changed to `...` throughout the package, so that passing on options to `httr::GET` is done via named parameters, e.g., `config=verbose()`. (#13)
* Added examples of doing curl debugging throughout man pages.


bold 0.1.2
===============

### MINOR IMPROVEMENTS

* Improved the vignette (#8)
* Added small function to print helpful message when user inputs no parameters or zero length parameter values.

### BUG FIXES

* Fixed some broken tests with the new `httr` (v0.4) (#9), and added a few more tests (#7)


bold 0.1.0
===============

### NEW FEATURES

* released to CRAN
