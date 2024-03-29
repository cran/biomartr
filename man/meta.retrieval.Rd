% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/meta.retrieval.R
\name{meta.retrieval}
\alias{meta.retrieval}
\title{Perform Meta-Genome Retrieval}
\usage{
meta.retrieval(
  db = "refseq",
  kingdom,
  group = NULL,
  type = "genome",
  restart_at_last = TRUE,
  reference = FALSE,
  combine = FALSE,
  path = NULL
)
}
\arguments{
\item{db}{a character string specifying the database from which the genome
shall be retrieved:

\itemize{
\item \code{db = "refseq"}
\item \code{db = "genbank"}
\item \code{db = "emsembl"}
}}

\item{kingdom}{a character string specifying the kingdom of the organisms
of interest, e.g.

\itemize{
\item For \code{NCBI RefSeq}:
\itemize{
\item \code{kingdom = "archaea"}
\item \code{kingdom = "bacteria"}
\item \code{kingdom = "fungi"}
\item \code{kingdom = "invertebrate"}
\item \code{kingdom = "plant"}
\item \code{kingdom = "protozoa"}
\item \code{kingdom = "viral"}
\item \code{kingdom = "vertebrate_mammalian"}
\item \code{kingdom = "vertebrate_other"}
}
\item For \code{NCBI Genbank}:
\itemize{
\item \code{kingdom = "archaea"}
\item \code{kingdom = "bacteria"}
\item \code{kingdom = "fungi"}
\item \code{kingdom = "invertebrate"}
\item \code{kingdom = "plant"}
\item \code{kingdom = "protozoa"}
\item \code{kingdom = "vertebrate_mammalian"}
\item \code{kingdom = "vertebrate_other"}
}
\item For \code{ENSEMBL}:
\itemize{
\item \code{kingdom = "EnsemblVertebrates"}
\item \code{kingdom = "EnsemblPlants"}
\item \code{kingdom = "EnsemblFungi"}
\item \code{kingdom = "EnsemblMetazoa"}
\item \code{kingdom = "EnsemblBacteria"}
\item \code{kingdom = "EnsemblProtists"}
}
}

Available kingdoms can be retrieved with \code{\link{getKingdoms}}.}

\item{group}{only species belonging to this subgroup will be downloaded.
Groups can be retrieved with \code{\link{getGroups}}.}

\item{type}{type of sequences that shall be retrieved. Options are:

\itemize{
 \item \code{type = "genome"} :
 (for genome assembly retrieval; see also \code{\link{getGenome}}),
 \item \code{type = "proteome"} :
 (for proteome retrieval; see also \code{\link{getProteome}}),
 \item \code{type = "cds"} :
 (for coding sequence retrieval; see also \code{\link{getCDS}}),
 \item \code{type = "gff"} :
(for annotation file retrieval in gff format; see also \code{\link{getGFF}}),
\item \code{type = "gtf"} :
(for annotation file retrieval in gtf format (only for ensembl and
 ensemblgenomes); see also \code{\link{getGTF}})
 \item \code{type = "rna"} :
 (for RNA file retrieval in fasta format; see also \code{\link{getRNA}}),
 \item \code{type = "rm"} :
 (for Repeat Masker output file retrieval; see also
 \code{\link{getRepeatMasker}}),
 \item \code{type = "assemblystats"} :
 (for genome assembly quality stats file retrieval;
 see also \code{\link{getAssemblyStats}}).
 }}

\item{restart_at_last}{a logical value indicating whether or not \code{meta.retrieval} should pick up at the last species when re-running the function.
\itemize{
\item If \code{restart_at_last = TRUE} (Default) then \code{meta.retrieval} will skip all organisms that are already present in the folder
and will start downloading all remaining species. However, this way \code{meta.wretrieval} will not be able to check whether
already downloaded organism files are corrupted or not by checking the md5 checksum.
\item If \code{restart_at_last = FALSE} then \code{meta.retrieval} will start from the beginning and crawl through already downloaded
organism files and check whether already downloaded organism files are corrupted or not by checking the md5 checksum.
After checking existing files the function will start downloading all remaining organisms.
}}

\item{reference}{a logical value indicating whether or not a genome shall be downloaded if it isn't marked in the database
as either a reference genome or a representative genome. Options are:
\itemize{
\item \code{reference = FALSE} (Default): all organisms (reference, representative, and non-representative genomes) are downloaded.
\item \code{reference = TRUE}: organisms that are downloaded must be either a reference or representative genome. Thus, most genomes which are usually non-reference genomes
will not be downloaded.
}}

\item{combine}{just in case \code{type = "assemblystats"} is specified, shall
assemby stats of individual species be imported and combined to a
\code{\link{data.frame}}?}

\item{path}{path to the folder in which downloaded genomes shall be stored.
By default the kingdom name is used to name the output folder.}
}
\value{
a character vector storing the file paths of the retrieved files.
}
\description{
Download genomes, proteomes, cds, gff, rna, or assembly stats
files of all species within a kingdom of life.
}
\details{
This function aims to perform bulk retrieval of the genomes,
proteomes, cds, etc. of species that belong to the same kingdom of life or
to the same subgroup.
}
\examples{
\dontrun{
# get all available kingdoms for refseq
getKingdoms(db = "refseq")
# download all vertebrate genomes from refseq
meta.retrieval(kingdom = "vertebrate_mammalian",
               db = "refseq",
               type = "genome")

# get all available kingdoms for genbank
getKingdoms(db = "genbank")
# download all vertebrate genomes from genbank
meta.retrieval(kingdom = "vertebrate_mammalian",
               db = "genbank",
               type = "genome")


# In case users do not wish to retrieve genomes from an entire kingdom,
# but rather from a subgoup (e.g. from species belonging to the
# Gammaproteobacteria class, a subgroup of the bacteria kingdom),
# they can use the following workflow"
# First, users can again consult the getKingdoms() function to retrieve
# kingdom information.
getKingdoms(db = "refseq")

# In this example, we will choose the bacteria kingdom.
# Now, the getGroups() function allows users to obtain available
# subgroups of the bacteria kingdom.
getGroups(db = "refseq", kingdom = "bacteria")

# Now we choose the group Gammaproteobacteria and specify
# the group argument in the meta.retrieval() function
meta.retrieval(kingdom = "bacteria",
   roup = "Gammaproteobacteria",
   db = "refseq",
   type = "genome")
}
}
\seealso{
Other meta_retrival: 
\code{\link{meta.retrieval.all}()}
}
\author{
Hajk-Georg Drost
}
\concept{meta_retrival}
