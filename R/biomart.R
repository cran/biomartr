#' @title Main BioMart Query Function
#' @description This function takes a set of gene ids and the biomart
#' specifications and performs a biomart query for the given set of gene ids.
#' @param genes a character vector storing the gene ids of a organisms
#'  of interest to be queried against BioMart.
#' @param mart a character string specifying the mart to be used. Users
#' can obtain available marts using \code{\link{getMarts}}.
#' @param dataset a character string specifying the dataset within the mart to
#'  be used, e.g. \code{dataset} = \code{"hsapiens_gene_ensembl"}.
#' @param attributes a character vector specifying the attributes that shall be
#'  used, e.g. \code{attributes} =
#'  \code{c("start_position","end_position","description")}.
#' @param filters a character vector specifying the filter (query key) for the
#' BioMart query, e.g. \code{filter} = \code{"ensembl_gene_id"}.
#' @param ... additional parameters for the
#'  \code{\link[biomaRt]{getBM}} function.
#' @param mute_citation logical value indicating whether citation message should be muted.
#' @author Hajk-Georg Drost
#' @details This function is the main query function of the biomartr package.
#'
#' It enables to fastly access annotations of a given gene set based
#' on the \pkg{biomaRt} package
#' implemented by Steffen Durinck et al.
#'
#' @examples
#' \dontrun{
#' # 1) select a mart
#' getMarts()
#'
#' # we will select mart 'plants_mart' and search for available datasets
#' getDatasets(mart = "plants_mart")
#'
#' # we choose dataset 'athaliana_eg_gene' and run biomart()
#' # using mart: 'plants_mart', dataset: "athaliana_eg_gene"
#' # attributes: c("start_position","end_position","description")
#' # for an example gene set of Arabidopsis thaliana:
#' # c("AT1G06090", "AT1G06100", "AT1G06110", "AT1G06120",
#' #    "AT1G06130", "AT1G06200")
#'
#' biomart(genes      = c("AT1G06090", "AT1G06100",
#'                        "AT1G06110", "AT1G06120",
#'                        "AT1G06130", "AT1G06200"),
#'         mart       = "plants_mart",
#'         dataset    = "athaliana_eg_gene",
#'         attributes = c("start_position","end_position","description"),
#'         filters    = "ensembl_gene_id")
#'}
#'
#' @return A data.table storing the initial query gene vector in
#' the first column, the output
#' gene vector in the second column, and all attributes in
#' the following columns.
#' @family biomaRt
#' @import biomaRt
#' @export
biomart <- function(genes,
                    mart,
                    dataset,
                    attributes,
                    filters,
                    mute_citation = FALSE,
                    ...) {

        message("Starting BioMart query ...")
  # connect to BioMart API
  host_url <- biomart_base_urls_select(mart)
  m <- m <- biomaRt::useMart(mart, host = host_url)

  d <- biomaRt::useDataset(dataset = dataset, mart = m)

  # establishing a biomaRt connection and retrieving the
  # information for the given gene list
  query <-
      biomaRt::getBM(
          attributes = as.character(c(filters, attributes)),
          filters    = as.character(filters),
          values     = as.character(genes),
          mart       = d,
          ...
      )

  colnames(query) <- c(filters, attributes)

  genes <- tibble::tibble(as.character(genes))
  colnames(genes) <- as.character(filters)

  tbl_biomart <-
      merge(query, genes, by = filters, incomparables = NA)

  please_cite_biomartr(mute_citation = mute_citation)
  return(tbl_biomart)

}
