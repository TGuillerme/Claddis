% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SafeTaxonomicReinsertion.R
\name{SafeTaxonomicReinsertion}
\alias{SafeTaxonomicReinsertion}
\title{Reinsert Safely Removed Taxa Into A Tree}
\usage{
SafeTaxonomicReinsertion(treefile.in, treefile.out, str.list,
  multi.placements = "exclude")
}
\arguments{
\item{treefile.in}{A Newick-formatted tree file containing tree(s) without safely removed taxa.}

\item{treefile.out}{A file name where the newly generated trees will be written out to (required).}

\item{str.list}{The safe taxonomic reduction table as generated by \link{SafeTaxonomicReduction}.}

\item{multi.placements}{An optional for what to do with taxa that have more than one possible reinsertion position. Options are \code{"exclude"} (does not reinsert them; the default) or \code{"random"} (picks one of the possible positions and uses that; will vary stochastically if multiple trees exist).}
}
\value{
Nothing is returned, but a new file (\code{treefile.out}) is written.
}
\description{
Following Safe Taxonomic Reduction reinsert removed taxa.
}
\details{
Explanatory text.
}
\examples{

# Nothing yet

}
\author{
Graeme T. Lloyd \email{graemetlloyd@gmail.com}
}
