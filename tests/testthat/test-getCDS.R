context("Test: getCDS()")


test_that("The getCDS() interface to NCBI RefSeq works properly and skips download when file already exists..",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "refseq",
                     organism = "Saccharomyces cerevisiae",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "refseq",
                     organism = "Saccharomyces cerevisiae",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})


test_that("The getCDS() interface to NCBI RefSeq works properly with taxid (including repeating the command)..",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "refseq",
                     organism = "559292",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "refseq",
                     organism = "559292",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})


test_that("The getCDS() interface to NCBI RefSeq works properly with assembly id (including repeating the command)..",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "refseq",
                     organism = "GCF_000146045.2",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "refseq",
                     organism = "GCF_000146045.2",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})

test_that("The getCDS() interface to NCBI Genbank works properly and skips download when file already exists..",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "genbank",
                     organism = "Saccharomyces cerevisiae",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "genbank",
                     organism = "Saccharomyces cerevisiae",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})


test_that("The getCDS() interface to NCBI Genbank works properly when using taxids (including repeating the command)..",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "genbank",
                     organism = "559292",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "genbank",
                     organism = "559292",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})


test_that("The getCDS() interface to NCBI Genbank works properly when using assembly id (including repeating the command) ...",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "genbank",
                     organism = "GCA_000146045.2",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "genbank",
                     organism = "GCA_000146045.2",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})

test_that("The getCDS() throws error when wrong 'db' is selected..",{
    skip_on_cran()
    skip_on_travis()
    expect_error(getCDS( db       = "somethingelse",
                           organism = "Saccharomyces cerevisi",
                           path     = tempdir(),
                         mute_citation = TRUE))
})

test_that("The getCDS() throws error when wrong 'organism' is selected..",{
    skip_on_cran()
    skip_on_travis()
    expect_equal(getCDS( db       = "refseq",
                         organism = "somethingelse",
                         path     = tempdir(),
                         mute_citation = TRUE), "Not available")
})


test_that("The getCDS() interface to Ensembl skips download when file already exists..",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "ensembl",
                     organism = "Saccharomyces cerevisiae",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "ensembl",
                     organism = "Saccharomyces cerevisiae",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})

test_that("getCDS() interface to Ensembl works with taxid and skips download when file already exists..",{

        skip_on_cran()
        skip_on_travis()
        out1 <- read_cds(getCDS( db       = "ensembl",
                         organism = "6239",
                         path     = tempdir(),
                         mute_citation = TRUE), format = "fasta")

        out2 <- read_cds(getCDS( db       = "ensembl",
                         organism = "6239",
                         path     = tempdir(),
                         mute_citation = TRUE), format = "fasta")
        expect_equal(out1, out2)
})

test_that("getCDS() interface to Ensembl works with accession id and skips download when file already exists....",{

    skip_on_cran()
    skip_on_travis()
    out1 <- read_cds(getCDS( db       = "ensembl",
                     organism = "GCA_000002985.3",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")

    out2 <- read_cds(getCDS( db       = "ensembl",
                     organism = "GCA_000002985.3",
                     path     = tempdir(),
                     mute_citation = TRUE), format = "fasta")
    expect_equal(out1, out2)
})

