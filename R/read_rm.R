#' @title Import Repeat Masker output file
#' @description This function reads an organism specific 
#' Repeat Masker output file.
#' @param file a character string specifying the path to the file 
#' storing the Repeat Masker output (e.g. retrieved with \code{\link{getRepeatMasker}}).
#' @author Hajk-Georg Drost
#' @details This function takes a string specifying the path to the 
#' Repeat Masker output file of interest as first argument.
#' @seealso \code{\link{getRepeatMasker}}, \code{\link{read_genome}}, 
#' \code{\link{read_proteome}}, \code{\link{read_gff}}, \code{\link{read_rna}}
#' @export

read_rm <- function(file) {
    
    rm_file <- readr::read_lines(file = file, skip = 2)
    rm_file <- lapply(rm_file, function(x) {
        str.res <- unlist(stringr::str_split(x, "\\s+"))[-1]
        str.res <- str.res[1:14]
        return(str.res)
    })
    
    
    rm_file <- as.data.frame(do.call(rbind, rm_file))
    colnames(rm_file) <- c(
        "sw_score",
        "perc_div",
        "perc_del",
        "perc_insert",
        "qry_id",
        "qry_start",
        "qry_end",
        "qry_left",
        "matching_repeat",
        "repeat_id",
        "matching_class",
        "no_bp_in_complement",
        "in_repeat_start",
        "in_repeat_end"
    )
    qry_end <- qry_start <- NULL
    
    rm_file <- tibble::as_tibble(rm_file)
    
    nrow_before_filtering <- nrow(rm_file)
        
    suppressWarnings(rm_file <- dplyr::mutate(rm_file,
                             qry_start = as.integer(qry_start),
                             qry_end = as.integer(qry_end)))
    
    
    rm_file <-
        dplyr::filter(
            rm_file,
            !is.na(qry_start),
            !is.na(qry_end)
        )
    
    rm_file <-
        dplyr::mutate(
            rm_file,
            qry_width = as.integer(qry_end - qry_start + 1L))

    nrow_after_filtering <- nrow(rm_file)
    
    
    if ((nrow_before_filtering - nrow_after_filtering) > 0)
        message((nrow_before_filtering - nrow_after_filtering) + 1 , " out of ",nrow_before_filtering," rows ~ ", round(((nrow_before_filtering - nrow_after_filtering) + 1) / nrow_before_filtering, 3) , "% were removed from the imported RepeatMasker file, ",
                "because they contained 'NA' values in either 'qry_start' or 'qry_end'.")
    
    return(rm_file)
}


