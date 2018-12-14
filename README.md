bold
====



[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![cran version](https://www.r-pkg.org/badges/version/bold)](https://cran.r-project.org/package=bold)


`bold` accesses BOLD barcode data.

The Barcode of Life Data Systems (BOLD) is designed to support the generation and application of DNA barcode data. The platform consists of four main modules: a data portal, a database of barcode clusters, an educational portal, and a data collection workbench.

This package retrieves data from the BOLD database of barcode clusters, and allows for searching of over 1.7M public records using multiple search criteria including sequence data, specimen data, specimen *plus* sequence data, as well as trace files.

[Documentation for the BOLD API](http://v4.boldsystems.org/index.php/api_home).

See also the taxize book for more options for taxonomic workflows with BOLD: <https://ropensci.github.io/taxize-book/>

## Package status and installation

[![cran checks](https://cranchecks.info/badges/worst/bold)](https://cranchecks.info/pkgs/bold)
[![Build Status](https://travis-ci.org/ropensci/bold.svg?branch=master)](https://travis-ci.org/ropensci/bold)
[![codecov.io](https://codecov.io/github/ropensci/bold/coverage.svg?branch=master)](https://codecov.io/github/ropensci/bold?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/bold)](https://github.com/metacran/cranlogs.app)

__Installation instructions__

__Stable Version__


```r
install.packages("bold")
```

__Development Version__

Install `sangerseqR` first


```r
source("http://bioconductor.org/biocLite.R")
biocLite("sangerseqR")
```

Then `bold`


```r
devtools::install_github("ropensci/bold")
```


## Usage

```r
library("bold")
```


### Search for sequence data only

Default is to get a list back


```r
bold_seq(taxon='Coelioxys')[[1]]
#> $id
#> [1] "ABEE013-17"
#> 
#> $name
#> [1] "Coelioxys afra"
#> 
#> $gene
#> [1] "ABEE013-17"
#> 
#> $sequence
#> [1] "AATATTATATATAATTTTTGCAATTTGATCAGGTATAATTGGATCTTCATTAAGAATAATTATTCGAATAGAATTAAGAACTCCAGGAAGATGAATCAACAACGATCAAATTTATAATTCTTTTATTACAGCTCATGCATTTTTAATAATTTTTTTTTTAGTAATACCATTTTTAATTGGAGGATTTGGAAATTGATTAGTACCTTTAATACTAGGAGCCCCCGATATAGCTTTTCCACGAATAAATAATGTAAGATTTTGACTATTACCTCCCTCAATTTTCTTATTATTATCAAGAACCCTAATTAACCCAAGAGCTGGTACTGGATGAACTGTATATCCTCCTTTATCCTTATATACATTTCATGCCTCACCTTCCGTTGATTTAGCAATTTTTTCACTTCATTTATCAGGAATTTCATCAATTATTGGATCAATAAATTTTATTGTTACAATCTTAATAATAAAAAATTTTTCTTTAAATTATAGACAAATACCATTATTTTCATGATCAGTTTTAATTACTACAATTTTACTTTTATTATCACTACCAATTTTAGCTGGAGCAATTACTATACTCCTATTTGATCGAAATTTAAATACCTCATTCTTTGACCCAATAGGAGGAGGAGATCCAATTTTATATCAACATTTATTT-----------------"
```

You can optionally get back the `crul` response object


```r
res <- bold_seq(taxon='Coelioxys', response=TRUE)
res$response_headers
#> $status
#> [1] "HTTP/1.1 200 OK"
#> 
#> $date
#> [1] "Wed, 14 Nov 2018 00:49:40 GMT"
#> 
#> $server
#> [1] "Apache/2.2.15 (Red Hat)"
#> 
#> $`x-powered-by`
#> [1] "PHP/5.3.15"
#> 
#> $`content-disposition`
#> [1] "attachment; filename=fasta.fas"
#> 
#> $connection
#> [1] "close"
#> 
#> $`transfer-encoding`
#> [1] "chunked"
#> 
#> $`content-type`
#> [1] "application/x-download"
```

### Search for specimen data only

By default you download `tsv` format data, which is given back to you as a `data.frame`


```r
res <- bold_specimens(taxon='Osmia')
head(res[,1:8])
#>     processid      sampleid recordID    catalognum
#> 1  ABEE151-17  NHMW-HYM 773  8362250              
#> 2  ABEE184-17 NHMW-HYM 2142  8362283 NHMW-HYM 2142
#> 3  ABEE185-17 NHMW-HYM 2144  8362284 NHMW-HYM 2144
#> 4  ABEE188-17 NHMW-HYM 2242  8362287 NHMW-HYM 2242
#> 5  ABEE190-17 NHMW-HYM 2259  8362289 NHMW-HYM 2259
#> 6 GBAH3878-08      EU726629   856409      EU726629
#>                                                       fieldnum
#> 1                                                             
#> 2 NBH2 Zimmermann 2017.04.03 Oesterreich WienAUTWienZimmermann
#> 3 NBH2 Zimmermann 2017.04.03 Oesterreich WienAUTWienZimmermann
#> 4       NHB3 Schoder 2017.05.30 Oesterreich WienAUTWienSchoder
#> 5       NBH9 Schoder 2017.06.15 Oesterreich WienAUTWienSchoder
#> 6                                                             
#>             institution_storing collection_code      bin_uri
#> 1 Naturhistorisches Museum Wien              NA BOLD:AAE5409
#> 2 Naturhistorisches Museum Wien              NA BOLD:AAE5409
#> 3 Naturhistorisches Museum Wien              NA BOLD:ADJ1069
#> 4 Naturhistorisches Museum Wien              NA BOLD:AAF2155
#> 5 Naturhistorisches Museum Wien              NA BOLD:AAD0313
#> 6      Mined from GenBank, NCBI              NA BOLD:AAA4494
```

### Search for specimen plus sequence data

By default you download `tsv` format data, which is given back to you as a `data.frame`


```r
res <- bold_seqspec(taxon='Osmia', sepfasta=TRUE)
res$fasta[1:2]
#> $`ABEE151-17`
#> [1] "----------------------------------------------------------TTTTTGCTATATGATCAGGTACAGTAGGTTCAGCTATAAGAATTATTATTCGAATAGAACTTAGAGTTCCAGGATCATGAATTTCTAATGACCAAATTTATAATACTTTAGTAACTGCTCATGCTTTTTTAATAATTTTCTTTCTTGTAATACCATTTCTAATTGGAGGATTTGGAAATTGATTAATTCCTTTAATATTAGGAATTCCAGATATAGCCTTTCCACGAATAAATAATATTAGATTTTGACTTTTACCACCTTCTTTAATATTATTAATATTAAGAAATTTTATAAATCCAAGTCCAGGAACTGGATGAACTGTTTATCCTCCTCTTTCATCTTATATATTTCATTCTTCCCCATCAGTAGATTTAGCAATTTTTTCATTACATATTTCCGGATTATCCTCTATTATAGGTTCATTAAATTTTATTGTCACAATTATTATAATAAAAAATATTTCATTAAAACATACTCAATTACCCTTATTTTCTTGATCTGTATTTATTACTACTATTTTATTACTTTTCTCTCTCCCAGTTTTAGCTGGAGCTATTACTATACTTTTATTTGATCGAAATTTTAACACCTCATTTTTTGACCCGACGGGAGGTGGAGATCCAATTTTATACCAACATTTATTTTGATTTTTTGGACAT-----------------------"
#> 
#> $`ABEE184-17`
#> [1] "-------CTCACTATAGGGATTCAACCAATCATAAAGATATTGGAATTCTTTATATAATTTTTGCTATATGATCAGGTACAGTAGGTTCAGCTATAAGAATTATTATTCGAATAGAACTTAGAGTTCCAGGATCATGAATTTCTAATGACCAAATTTATAATACTTTAGTAACTGCTCATGCTTTTTTAATAATTTTCTTTCTTGTAATACCATTTCTAATTGGAGGATTTGGAAATTGATTAATTCCTTTAATATTAGGAATTCCAGATATAGCCTTTCCACGAATAAATAATATTAGATTTTGACTTTTACCACCTTCTTTAATATTATTAATATTAAGAAATTTTATAAATCCAAGTCCAGGAACTGGATGAACTGTTTATCCTCCTCTTTCATCTTATATATTTCATTCTTCCCCATCAGTAGATTTAGCAATTTTTTCATTACATATTTCCGGATTATCCTCTATTATAGGTTCATTAAATTTTATTGTCACAATTATTATAATAAAAAATATTTCATTAAAACATACTCAATTACCCTTATTTTCTTGATCTGTATTTATTACTACTATTTTATTACTTTTCTCTCTCCCAGTTTTAGCTGGAGCTATTACTATACTTTTATTTGATCGAAATTTTAACACCTCATTTTTTGACC-------------------------------------------------------------------------------"
```

Or you can index to a specific sequence like


```r
res$fasta['GBAH0293-06']
#> $`GBAH0293-06`
#> [1] "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------TTAATGTTAGGGATTCCAGATATAGCTTTTCCACGAATAAATAATATTAGATTTTGACTGTTACCTCCATCTTTAATATTATTACTTTTAAGAAATTTTTTAAATCCAAGTCCTGGAACAGGATGAACAGTTTATCCTCCTTTATCATCAAATTTATTTCATTCTTCTCCTTCAGTTGATTTAGCAATTTTTTCTTTACATATTTCAGGTTTATCTTCTATTATAGGTTCATTAAATTTTATTGTTACAATTATTATAATAAAAAATATTTCTTTAAAATATATTCAATTACCTTTATTTTCTTGATCTGTATTTATTACTACTATTCTTTTATTATTTTCTTTACCTGTATTAGCTGGAGCTATTACTATATTATTATTTGATCGAAATTTTAATACATCTTTTTTTGATCCAACAGGAGGGGGAGATCCAATTCTTTATCAACATTTATTTTGATTTTTTGGTCATCCTGAAGTTTATATTTTAATTTTACCTGGATTTGGATTAATTTCTCAAATTATTTCTAATGAAAGAGGAAAAAAAGAAACTTTTGGAAATATTGGTATAATTTATGCTATATTAAGAATTGGACTTTTAGGTTTTATTGTT---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
```

### Get trace files

This function downloads files to your machine - it does not load them into your R session - but prints out where the files are for your information.


```r
x <- bold_trace(ids = 'ACRJP618-11', progress = FALSE)
read_trace(x$ab1)
#> Number of datapoints: 8877
#> Number of basecalls: 685
#> 
#> Primary Basecalls: NNNNNNNNNNNNNNNNNNGNNNTTGAGCAGGNATAGTAGGANCTTCTCTTAGTCTTATTATTCGAACAGAATTAGGAAATCCAGGATTTTTAATTGGAGATGATCAAATCTACAATACTATTGTTACGGCTCATGCTTTTATTATAATTTTTTTTATAGTTATACCTATTATAATTGGAGGATTTGGTAATTGATTAGTTCCCCTTATACTAGGAGCCCCAGATATAGCTTTCCCTCGAATAAACAATATAAGTTTTTGGCTTCTTCCCCCTTCACTATTACTTTTAATTTCCAGAAGAATTGTTGAAAATGGAGCTGGAACTGGATGAACAGTTTATCCCCCACTGTCATCTAATATTGCCCATAGAGGTACATCAGTAGATTTAGCTATTTTTTCTTTACATTTAGCAGGTATTTCCTCTATTTTAGGAGCGATTAATTTTATTACTACAATTATTAATATACGAATTAACAGTATAAATTATGATCAAATACCACTATTTGTGTGATCAGTAGGAATTACTGCTTTACTCTTATTACTTTCTCTTCCAGTATTAGCAGGTGCTATCACTATATTATTAACGGATCGAAATTTAAATACATCATTTTTTGATCCTGCAGGAGGAGGAGATCCAATTTTATATCAACATTTATTTTGATTTTTTGGACNTCNNNNAAGTTTAAN
#> 
#> Secondary Basecalls:
```

### Large data

Sometimes with `bold_seq()` you request a lot of data, which can cause problems due 
to BOLD's servers. 

An example is the taxonomic name _Arthropoda_. When you send a request like 
`bold_seq(taxon = "Arthropoda")` BOLD attempts to give you back sequences
for all records under _Arthropoda_. This, as you can imagine, is a lot of 
sequences. 



```r
library("taxize")
```

Using `taxize::downstream` get children of _Arthropoda_


```r
x <- downstream("Arthropoda", db = "ncbi", downto = "class")
nms <- x$Arthropoda$childtaxa_name
```

Optionally, check that the name exists in BOLD's data. Any that are not in 
BOLD will give back a row of NAs


```r
checks <- bold_tax_name(nms)
# all is good
checks[,1:5]
#>     taxid         taxon tax_rank tax_division parentid
#> 1   26059   Pycnogonida    class      Animals       20
#> 2      63     Arachnida    class      Animals       20
#> 3      74   Merostomata    class      Animals       20
#> 4  493944     Pauropoda    class      Animals       20
#> 5   80390      Symphyla    class      Animals       20
#> 6      85     Diplopoda    class      Animals       20
#> 7      75     Chilopoda    class      Animals       20
#> 8      82       Insecta    class      Animals       20
#> 9     372    Collembola    class      Animals       20
#> 10 734357       Protura    class      Animals       20
#> 11     84     Remipedia    class      Animals       20
#> 12     73 Cephalocarida    class      Animals       20
#> 13     68  Branchiopoda    class      Animals       20
#> 14 765970   Hexanauplia    class      Animals       20
#> 15     69  Malacostraca    class      Animals       20
#> 16 889450 Ichthyostraca    class      Animals       20
#> 17     80     Ostracoda    class      Animals       20
```

Then pass those names to `bold_seq()`. You could pass all names in at once,
but we're trying to avoid the large data request problem here, so run each 
one separately with `lapply` or a for loop like request. 


```r
out <- lapply(nms, bold_seq)
```

## Citation

Get citation information for `bold` in R by running: `citation(package = 'bold')`

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/bold/issues)
* License: MIT
* Get citation information for `bold` in R doing `citation(package = 'bold')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
