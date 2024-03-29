tidy_name <- function(x, split_on = "_") {
    new_spec_names <- unlist(lapply(x, function(y) {
        split_str <- unlist(stringr::str_split(y, split_on))
            return(paste0(
                stringr::str_to_upper(stringr::str_sub(split_str[1], 1, 1)),
                stringr::str_sub(split_str[1], 2, nchar(split_str[1])),
                stringr::str_to_upper(stringr::str_sub(split_str[2],1,1)),
                stringr::str_sub(split_str[2], 2, nchar(split_str[2])),
                collapse = ""
            ))
    }))

    return(new_spec_names)
}

tidy_name2 <- function(x) {
  tidy_name(x, split_on = " ")
}

#' @title Transform 1st character of a string to upper case
#' @description Helper function to only transform 1st character of a string
#' to upper case.
#' @param string character string that shall be transformed.
#' @author Hajk-Georg Drost
#' @noRd
toupper_first_char <- function(string) {
  return(stringr::str_c(stringr::str_to_upper(stringr::str_sub(string,1,1)),
                        stringr::str_sub(string,2,nchar(string)),
                        collapse = ""))
}

ensembl_fix_wrong_naming <- function(organism) {
  organism <-
    stringr::str_replace_all(organism, " sp ", " sp. ")
  organism <-
    stringr::str_replace_all(organism, " pv ", " pv. ")
  organism <-
    stringr::str_replace_all(organism, " str ", " str. ")
  organism <-
    stringr::str_replace_all(organism, " subsp ", " subsp. ")
  organism <-
    stringr::str_replace_all(organism, "\\(", "")
  organism <-
    stringr::str_replace_all(organism, "\\)", "")
}

ensembl_proper_organism_name <- function(ensembl_summary) {
  new.organism <- ensembl_summary$name[1]
  new.organism <-
    paste0(
      stringr::str_to_upper(stringr::str_sub(new.organism, 1, 1)),
      stringr::str_sub(new.organism, 2, nchar(new.organism))
    )
  new.organism <- ensembl_fix_wrong_naming(new.organism)
}

lower_cap_underscore_organism_name <- function(organism) {
  stringr::str_to_lower(stringr::str_replace_all(organism, " ", "_"))
}
