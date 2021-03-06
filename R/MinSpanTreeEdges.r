#' Get edges of minimum spanning tree
#' 
#' Returns edges of a minimum spanning tree given a distance matrix.
#' 
#' This function is a wrapper for \link{mst} in the \link{ape} package, but returns a vector of edges rather than a square matrix of links.
#' 
#' @param dist.matrix A square matrix of distances between objects.
#'
#' @return A vector of named edges (X->Y) with their distances. The sum of this vector is the length of the minimum spanning tree.
#'
#' @author Graeme T. Lloyd \email{graemetlloyd@@gmail.com}
#'
#' @examples
#' 
#' # Create a simple square matrix of distances:
#' dist.matrix <- matrix(c(0,1,2,3,1,0,1,2,2,1,0,1,3,2,1,0), nrow = 4,
#'   dimnames = list(LETTERS[1:4], LETTERS[1:4]))
#' 
#' # Show matrix to confirm that the off diagonal has the shortest
#' # distances:
#' dist.matrix
#' 
#' # Use MinSpanTreeEdges to get the edges for the minimum spanning
#' # tree:
#' MinSpanTreeEdges(dist.matrix)
#' 
#' # Use sum of MinSpanTreeEdges to get the length of the minimum
#' # spanning tree:
#' sum(MinSpanTreeEdges(dist.matrix))
#' 
#' @export MinSpanTreeEdges
MinSpanTreeEdges <- function(dist.matrix) {
	
	# Convert to matrix and set up links matrix:
	dist.matrix <- as.matrix(dist.matrix)

	# Get links matrix for minimum spanning tree:
	links.matrix <- mst(dist.matrix)
	
	# Update matrix class to NULL:
	class(links.matrix) <- NULL
	
	# Create empty matrix to store edges for minimum spanning tree:
	min.span.tree.edges <- matrix(nrow=0, ncol=2, dimnames=list(c(), c("From", "To")))
	
	# For each row:
	for(i in 1:(nrow(links.matrix) - 1)) {
		
		# For each column:
		for(j in (i + 1):ncol(links.matrix)) {
			
			# If there is a link then record it:
			if(links.matrix[i, j] == 1) min.span.tree.edges <- rbind(min.span.tree.edges, c(rownames(links.matrix)[i], colnames(links.matrix)[j]))
			
		}
		
	}
	
	# Get distances:
	distances <- diag(dist.matrix[min.span.tree.edges[, "From"], min.span.tree.edges[, "To"]])
	
	# Add names to distances:
	names(distances) <- apply(min.span.tree.edges, 1, paste, collapse="->")
	
	# Output distances for minimum soanning tree:
	return(distances)
		
}
