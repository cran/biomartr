#' @title Perform Meta-Genome Retrieval
#' @description Download genomes, proteomes, cds, gff, rna, or assembly stats
#' files of all species within a kingdom of life.
#' @param db a character string specifying the database from which the genome
#' shall be retrieved:
#'
#' \itemize{
#' \item \code{db = "refseq"}
#' \item \code{db = "genbank"}
#' \item \code{db = "emsembl"}
#' }
#' @param kingdom a character string specifying the kingdom of the organisms
#' of interest, e.g.
#'
#' \itemize{
#' \item For \code{NCBI RefSeq}:
#' \itemize{
#' \item \code{kingdom = "archaea"}
#' \item \code{kingdom = "bacteria"}
#' \item \code{kingdom = "fungi"}
#' \item \code{kingdom = "invertebrate"}
#' \item \code{kingdom = "plant"}
#' \item \code{kingdom = "protozoa"}
#' \item \code{kingdom = "viral"}
#' \item \code{kingdom = "vertebrate_mammalian"}
#' \item \code{kingdom = "vertebrate_other"}
#' }
#' \item For \code{NCBI Genbank}:
#' \itemize{
#' \item \code{kingdom = "archaea"}
#' \item \code{kingdom = "bacteria"}
#' \item \code{kingdom = "fungi"}
#' \item \code{kingdom = "invertebrate"}
#' \item \code{kingdom = "plant"}
#' \item \code{kingdom = "protozoa"}
#' \item \code{kingdom = "vertebrate_mammalian"}
#' \item \code{kingdom = "vertebrate_other"}
#' }
#' \item For \code{ENSEMBL}:
#' \itemize{
#' \item \code{kingdom = "EnsemblVertebrates"}
#' \item \code{kingdom = "EnsemblPlants"}
#' \item \code{kingdom = "EnsemblFungi"}
#' \item \code{kingdom = "EnsemblMetazoa"}
#' \item \code{kingdom = "EnsemblBacteria"}
#' \item \code{kingdom = "EnsemblProtists"}
#' }
#' }
#'
#' Available kingdoms can be retrieved with \code{\link{getKingdoms}}.
#' @param group only species belonging to this subgroup will be downloaded.
#' Groups can be retrieved with \code{\link{getGroups}}.
#' @param type type of sequences that shall be retrieved. Options are:
#'
#' \itemize{
#'  \item \code{type = "genome"} :
#'  (for genome assembly retrieval; see also \code{\link{getGenome}}),
#'  \item \code{type = "proteome"} :
#'  (for proteome retrieval; see also \code{\link{getProteome}}),
#'  \item \code{type = "cds"} :
#'  (for coding sequence retrieval; see also \code{\link{getCDS}}),
#'  \item \code{type = "gff"} :
#' (for annotation file retrieval in gff format; see also \code{\link{getGFF}}),
#' \item \code{type = "gtf"} :
#' (for annotation file retrieval in gtf format (only for ensembl and
#'  ensemblgenomes); see also \code{\link{getGTF}})
#'  \item \code{type = "rna"} :
#'  (for RNA file retrieval in fasta format; see also \code{\link{getRNA}}),
#'  \item \code{type = "rm"} :
#'  (for Repeat Masker output file retrieval; see also
#'  \code{\link{getRepeatMasker}}),
#'  \item \code{type = "assemblystats"} :
#'  (for genome assembly quality stats file retrieval;
#'  see also \code{\link{getAssemblyStats}}).
#'  }
#' @param restart_at_last a logical value indicating whether or not \code{meta.retrieval} should pick up at the last species when re-running the function.
#' \itemize{
#' \item If \code{restart_at_last = TRUE} (Default) then \code{meta.retrieval} will skip all organisms that are already present in the folder
#' and will start downloading all remaining species. However, this way \code{meta.wretrieval} will not be able to check whether
#' already downloaded organism files are corrupted or not by checking the md5 checksum.
#' \item If \code{restart_at_last = FALSE} then \code{meta.retrieval} will start from the beginning and crawl through already downloaded
#' organism files and check whether already downloaded organism files are corrupted or not by checking the md5 checksum.
#' After checking existing files the function will start downloading all remaining organisms.
#' }
#' @param reference a logical value indicating whether or not a genome shall be downloaded if it isn't marked in the database
#' as either a reference genome or a representative genome. Options are:
#' \itemize{
#' \item \code{reference = FALSE} (Default): all organisms (reference, representative, and non-representative genomes) are downloaded.
#' \item \code{reference = TRUE}: organisms that are downloaded must be either a reference or representative genome. Thus, most genomes which are usually non-reference genomes
#' will not be downloaded.
#' }
#' @param combine just in case \code{type = "assemblystats"} is specified, shall
#' assemby stats of individual species be imported and combined to a
#' \code{\link{data.frame}}?
#' @param path path to the folder in which downloaded genomes shall be stored.
#' By default the kingdom name is used to name the output folder.
#' @author Hajk-Georg Drost
#' @details This function aims to perform bulk retrieval of the genomes,
#' proteomes, cds, etc. of species that belong to the same kingdom of life or
#' to the same subgroup.
#' @examples
#' \dontrun{
#' # get all available kingdoms for refseq
#' getKingdoms(db = "refseq")
#' # download all vertebrate genomes from refseq
#' meta.retrieval(kingdom = "vertebrate_mammalian",
#'                db = "refseq",
#'                type = "genome")
#'
#' # get all available kingdoms for genbank
#' getKingdoms(db = "genbank")
#' # download all vertebrate genomes from genbank
#' meta.retrieval(kingdom = "vertebrate_mammalian",
#'                db = "genbank",
#'                type = "genome")
#'
#'
#' # In case users do not wish to retrieve genomes from an entire kingdom,
#' # but rather from a subgoup (e.g. from species belonging to the
#' # Gammaproteobacteria class, a subgroup of the bacteria kingdom),
#' # they can use the following workflow"
#' # First, users can again consult the getKingdoms() function to retrieve
#' # kingdom information.
#' getKingdoms(db = "refseq")
#'
#' # In this example, we will choose the bacteria kingdom.
#' # Now, the getGroups() function allows users to obtain available
#' # subgroups of the bacteria kingdom.
#' getGroups(db = "refseq", kingdom = "bacteria")
#'
#' # Now we choose the group Gammaproteobacteria and specify
#' # the group argument in the meta.retrieval() function
#' meta.retrieval(kingdom = "bacteria",
#'    roup = "Gammaproteobacteria",
#'    db = "refseq",
#'    type = "genome")
#' }
#' @family meta_retrival
#' @return a character vector storing the file paths of the retrieved files.
#' @export
meta.retrieval <- function(db         = "refseq",
                           kingdom,
                           group = NULL,
                           type       = "genome",
                           restart_at_last = TRUE,
                           reference  = FALSE,
                           combine    = FALSE,
                           path = NULL) {

    division <- subgroup <- NULL

    subfolders <- getKingdoms(db = db)

    if (!is.element(kingdom, subfolders))
        stop(paste0(
            "Please select a valid kingdom: ",
            paste0(subfolders, collapse = ", ")
        ), call. = FALSE)

    if (!is.null(group))
        if (!is.element(group, getGroups(kingdom = kingdom, db = db)))
            stop(
                "Please specify a group that is supported by getGroups().
                Your specification '",
                group,
                "' does not exist in getGroups(kingdom = '",
                kingdom,
                "', db = '",
                db,
                "'). Maybe you used a different db argument in getGroups()?",
                call. = FALSE
            )

    if (!is.element(type,
                    c("genome", "proteome", "CDS","cds", "gff",
                      "rna", "assemblystats", "gtf", "rm")))
        stop(
        "Please choose either type: type = 'genome', type = 'proteome',
        type = 'CDS', type = 'gff', type = 'gtf',
        type = 'rna', type = 'rm', or type = 'assemblystats'.",
            call. = FALSE
        )

    if (!is.element(db, c("refseq", "genbank", "ensembl")))
        stop(
            "Please select einter db = 'refseq', db = 'genbank', or
            db = 'ensembl'.",
            call. = FALSE
        )

    if ((stringr::str_to_upper(type) == "CDS") && (db == "genbank"))
        stop("Genbank does not store CDS data. Please choose 'db = 'refseq''.",
             call. = FALSE)

    if ((type == "gtf") && (is.element(db, c("genbank", "refseq"))))
            stop("GTF files are only available for type = 'ensembl' and type = 'ensemblgebomes'.")

    if (type == "assemblystats" &&
        !is.element(db, c("refseq", "genbank")))
        stop(
            "Unfortunately, assembly stats files are only available for
            db = 'refseq' and db = 'genbank'.",
            call. = FALSE
        )

    if (combine && type != "assemblystats")
        stop(
            "Only option type = 'assemblystats' can use combine = TRUE. Please
            specify: type = 'assemblystats' and combine = TRUE.",
            call. = FALSE
        )

    if ((type == "rm") && (!is.element(db, c("refseq", "genbank"))))
        stop("Repeat Masker output files can only be retrieved from 'refseq'",
             " or 'genbank'.", call. = FALSE)


    if (is.element(db, c("refseq", "genbank"))) {
        if (is.null(group)) {
            assembly.summary.file <-
                getSummaryFile(db = db, kingdom = kingdom)
            #assembly.summary.file <-
            #    dplyr::mutate(assembly.summary.file,
            #    organism_name = clean.str.brackets(organism_name))
            FinalOrganisms <-
                unique(assembly.summary.file$organism_name)
            #organism_name <- NULL

        }

        if (!is.null(group)) {
            groups.selection <-
                listGroups(kingdom = kingdom,
                           db = db,
                           details = TRUE)
            groups.selection <-
                dplyr::filter(groups.selection, subgroup %in% group)
            FinalOrganisms <- unique(groups.selection$organism_name)
        }
    }

    if (db %in% c("ensembl", "ensemblgenomes")) {
        ensembl_names <- getKingdoms(db = db)
        summary.file <- get.ensembl.info(division = names(ensembl_names[which(ensembl_names == kingdom)]))
        FinalOrganisms <- unique(summary.file$name)
        FinalOrganisms <-
            stringr::str_replace_all(FinalOrganisms, "_", " ")
        stringr::str_sub(FinalOrganisms, 1, 1) <-
            stringr::str_to_upper(stringr::str_sub(FinalOrganisms, 1, 1))
    }


    if (is.null(group))
        message(paste0(
            "Starting meta retrieval of all ",
            type,
            " files for kingdom: ",
            kingdom,
            " from database: ", db,
            "."
        ))
    if (!is.null(group))
        message(
            paste0(
                "Starting meta retrieval of all ",
                type,
                " files within kingdom '",
                kingdom,
                "' and subgroup '",
                group,"' ",
                " from database: ",
                db,
                "."
            )
        )
    message("\n")

    if (!is.null(path)) {
        if (!file.exists(path)) {
            message("Generating folder ", path, " ...")
            dir.create(path, recursive = TRUE)
        }

        if (!file.exists(file.path(path, "documentation")))
            dir.create(file.path(path, "documentation"))
    } else {
        if (!file.exists(kingdom)) {
            message("Generating folder ", kingdom, " ...")
            dir.create(kingdom, recursive = TRUE)
        }
        if (!file.exists(file.path(kingdom, "documentation")))
            dir.create(file.path(kingdom, "documentation"))
    }

    paths <- vector("character", length(FinalOrganisms))


    if (is.element(db, c("refseq", "genbank"))) {
        if (type == "genome") internal_type <- "genomic"
        if (type == "proteome") internal_type <- "protein"
        if (stringr::str_to_upper(type) == "CDS") internal_type <- "cds"
        if (type == "gff") internal_type <- "genomic"
        if (type == "gtf") internal_type <- db
        if (type == "rna") internal_type <- "rna"
        if (type == "rm") internal_type <- "rm"
        if (type == "assemblystats") internal_type <- "assembly"


        if (!is.null(path)) {
            .existingOrgs <- existingOrganisms(path = path, .type = internal_type)
        } else {
            .existingOrgs <- existingOrganisms(path = kingdom, .type = internal_type)
        }

    }


    if (db == "ensembl") {

        if (type == "genome") internal_type <- "dna"
        if (type == "proteome") internal_type <- "pep"
        if (stringr::str_to_upper(type) == "CDS") internal_type <- "cds"
        if (type == "gff") internal_type <- "ensembl"
        if (type == "gtf") internal_type <- "ensembl"
        if (type == "rna") internal_type <- "ncrna"

        if (!is.null(path)) {
            .existingOrgs <- existingOrganisms_ensembl(path = path, .type = internal_type)
        } else {
            .existingOrgs <- existingOrganisms_ensembl(path = kingdom, .type = internal_type)
        }
    }

    if (db == "ensemblgenomes") {
        if (type == "genome") internal_type <- "dna"
        if (type == "proteome") internal_type <- "pep"
        if (stringr::str_to_upper(type) == "CDS") internal_type <- "cds"
        if (type == "gff") internal_type <- "ensemblgenomes"
        if (type == "gtf") internal_type <- "ensemblgenomes"
        if (type == "rna") internal_type <- "ncrna"

        if (!is.null(path)) {
            .existingOrgs <- existingOrganisms_ensembl(path = path, .type = internal_type)
        } else {
            .existingOrgs <- existingOrganisms_ensembl(path = kingdom, .type = internal_type)
        }

    }

    if (length(.existingOrgs) > 0) {
        if (restart_at_last) {
            FinalOrganisms <- dplyr::setdiff(FinalOrganisms, .existingOrgs)
            if (length(FinalOrganisms) > 0) {
                message("Skipping already downloaded species: ", paste0(.existingOrgs, collapse = ", "))
                message("\n")
            }
        }
    }

    if (length(FinalOrganisms) > 0) {

        if (type == "genome") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getGenome(db        = db,
                                          organism  = FinalOrganisms[i],
                                          reference = reference,
                                          path      = kingdom,
                                          mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getGenome(db       = db,
                                          organism = FinalOrganisms[i],
                                          reference = reference,
                                          path     = path,
                                          mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (type == "proteome") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getProteome(db       = db,
                                            organism = FinalOrganisms[i],
                                            reference = reference,
                                            path     = kingdom,
                                            mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getProteome(db       = db,
                                            organism = FinalOrganisms[i],
                                            reference = reference,
                                            path     = path,
                                            mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (stringr::str_to_upper(type) == "CDS") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getCDS(db       = db,
                                       organism = FinalOrganisms[i],
                                       reference = reference,
                                       path     = kingdom,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getCDS(db       = db,
                                       organism = FinalOrganisms[i],
                                       reference = reference,
                                       path     = path,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (type == "gff") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getGFF(db       = db,
                                       organism = FinalOrganisms[i],
                                       reference = reference,
                                       path     = kingdom,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getGFF(db       = db,
                                       organism = FinalOrganisms[i],
                                       reference = reference,
                                       path     = path,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (type == "gtf") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getGTF(db       = db,
                                       organism = FinalOrganisms[i],
                                       path     = kingdom,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getGTF(db       = db,
                                       organism = FinalOrganisms[i],
                                       path     = path,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (type == "rm") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getRepeatMasker(db       = db,
                                                organism = FinalOrganisms[i],
                                                reference = reference,
                                                path     = kingdom,
                                                mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getRepeatMasker(db       = db,
                                                organism = FinalOrganisms[i],
                                                reference = reference,
                                                path     = path,
                                                mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (type == "rna") {
            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    paths[i] <- getRNA(db       = db,
                                       organism = FinalOrganisms[i],
                                       reference = reference,
                                       path     = kingdom,
                                       mute_citation = TRUE)
                    message("\n")
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    getRNA(db       = db,
                           organism = FinalOrganisms[i],
                           reference = reference,
                           path     = path,
                           mute_citation = TRUE)
                    message("\n")
                }
            }
        }

        if (type == "assemblystats") {
            stats.files <- vector("list", length(FinalOrganisms))

            if (is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    if (combine) {
                        stats.files[i] <- list(
                            getAssemblyStats(
                                db       = db,
                                organism = FinalOrganisms[i],
                                reference = reference,
                                path     = kingdom,
                                type     = "import",
                                mute_citation = TRUE
                            )
                        )
                        names(stats.files[i]) <- FinalOrganisms[i]
                        message("\n")
                    } else {
                        paths[i] <- getAssemblyStats(
                            db       = db,
                            organism = FinalOrganisms[i],
                            reference = reference,
                            path     = kingdom,
                            mute_citation = TRUE
                        )
                        message("\n")
                    }
                }
            }

            if (!is.null(path)) {
                for (i in seq_len(length(FinalOrganisms))) {
                    if (combine) {
                        stats.files[i] <- list(
                            getAssemblyStats(
                                db       = db,
                                organism = FinalOrganisms[i],
                                reference = reference,
                                path     = path,
                                type     = "import",
                                mute_citation = TRUE
                            )
                        )
                        names(stats.files[i]) <- FinalOrganisms[i]
                    } else {
                        paths[i] <- getAssemblyStats(
                            db       = db,
                            reference = reference,
                            organism = FinalOrganisms[i],
                            path     = path,
                            mute_citation = TRUE
                        )
                    }
                }
            }
        }


        if (!is.null(path)) {
            meta_files <- list.files(path)
            meta_files <- meta_files[stringr::str_detect(meta_files, "doc_")]
            file.rename(from = file.path(path, meta_files), to = file.path(path, "documentation", meta_files))

            doc_tsv_files <- file.path(path,"documentation", meta_files[stringr::str_detect(meta_files, "[.]tsv")])

            summary_log <- dplyr::bind_rows(lapply(doc_tsv_files, function(data) {
              if (fs::file_size(data) > 0)
                suppressMessages(readr::read_tsv(data))
            }))

            readr::write_excel_csv(summary_log, file.path(path, "documentation", paste0(kingdom, "_summary.csv")))
            message("A summary file (which can be used as supplementary information file in publications) containig retrieval information for all ",kingdom," species has been stored at '",file.path(path, "documentation", paste0(kingdom, "_summary.csv")),"'.")

        } else {
            meta_files <- list.files(kingdom)
            meta_files <- meta_files[stringr::str_detect(meta_files, "doc_")]
            file.rename(from = file.path(kingdom, meta_files), to = file.path(kingdom, "documentation", meta_files))

            doc_tsv_files <- file.path(kingdom,"documentation", meta_files[stringr::str_detect(meta_files, "[.]tsv")])

            summary_log <- dplyr::bind_rows(lapply(doc_tsv_files, function(data) {
              if (fs::file_size(data) > 0)
                suppressMessages(readr::read_tsv(data))
            }))

            readr::write_excel_csv(summary_log, file.path(kingdom, "documentation", paste0(kingdom, "_summary.csv")))
            message("A summary file (which can be used as supplementary information file in publications) containig retrieval information for all ",kingdom," species has been stored at '",file.path(kingdom, "documentation", paste0(kingdom, "_summary.csv")),"'.")

        }

        if (combine) {
            stats.files <- dplyr::bind_rows(stats::na.omit(stats.files))
            message("Finished meta retieval process.")
            return(stats.files)
        }

        message("Finished meta retieval process.")
        return(paths[!is.element(paths, c("FALSE", "Not available"))])
    } else {

        if (!is.null(path)) {
            meta_files <- list.files(path)
            meta_files <- meta_files[stringr::str_detect(meta_files, "doc_")]
            file.rename(from = file.path(path, meta_files), to = file.path(path, "documentation", meta_files))

            doc_tsv_files <- file.path(path,"documentation", meta_files[stringr::str_detect(meta_files, "[.]tsv")])

            summary_log <- dplyr::bind_rows(lapply(doc_tsv_files, function(data) {
              if (fs::file_size(data) > 0)
                suppressMessages(readr::read_tsv(data))
            }))

            readr::write_excel_csv(summary_log, file.path(path, "documentation", paste0(kingdom, "_summary.csv")))
            message("A summary file (which can be used as supplementary information file in publications) containig retrieval information for all ",kingdom," species has been stored at '",file.path(path, "documentation", paste0(kingdom, "_summary.csv")),"'.")

        } else {
            meta_files <- list.files(kingdom)
            meta_files <- meta_files[stringr::str_detect(meta_files, "doc_")]
            file.rename(from = file.path(kingdom, meta_files), to = file.path(kingdom, "documentation", meta_files))

            doc_tsv_files <- file.path(kingdom,"documentation", meta_files[stringr::str_detect(meta_files, "[.]tsv")])

            summary_log <- dplyr::bind_rows(lapply(doc_tsv_files, function(data) {
              if (fs::file_size(data) > 0)
                suppressMessages(readr::read_tsv(data))
            }))

            readr::write_excel_csv(summary_log, file.path(kingdom, "documentation", paste0(kingdom, "_summary.csv")))
            message("A summary file (which can be used as supplementary information file in publications) containig retrieval information for all ",kingdom," species has been stored at '",file.path(kingdom, "documentation", paste0(kingdom, "_summary.csv")),"'.")

        }

        message("The ", type,"s of all species have already been downloaded! You are up to date!")
        please_cite_biomartr()
    }
}



