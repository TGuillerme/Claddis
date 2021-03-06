#' Plots character changes on branches
#' 
#' Plots character changes in boxes on branches.
#'
#' Takes the \code{character.changes} output from \link{DiscreteCharacterRate} and plots it on the tree used to generate it.
#' 
#' @param character.changes A matrix of character changes.
#' @param tree Tree on which character changes occur.
#'
#' @return A plot of character changes on a tree.
#'
#' @author Graeme T. Lloyd \email{graemetlloyd@@gmail.com}
#'
#' @examples
#'
#' # Set random seed:
#' set.seed(17)
#'
#' # Generate a random tree for the Michaux data set:
#' tree <- rtree(nrow(Michaux1989$matrix))
#'
#' # Update taxon names to match those in the data matrix:
#' tree$tip.label <- rownames(Michaux1989$matrix)
#'
#' # Set root time by making youngest taxon extant:
#' tree$root.time <- max(diag(vcv(tree)))
#'
#' # Get discrete character rates (includes changes):
#' out <- DiscreteCharacterRate(tree, Michaux1989,
#'   seq(tree$root.time, 0, length.out = 3), alpha = 0.01)
#'
#' # Plot character changes on the tree:
#' PlotCharacterChanges(out$character.changes, tree)
#'
#' @export PlotCharacterChanges
PlotCharacterChanges <- function(character.changes, tree) {
	
    # Update tree edge lengths to number of character changes:
    tree$edge.length <- rle(sort(c(character.changes[, "Branch"], 1:nrow(tree$edge))))$lengths - 1
    
    # Create empty edge labels vector:
    edge.labels <- rep(NA, nrow(tree$edge))
    
    # For each edge:
    for(i in 1:nrow(tree$edge)) {
        
        # Get rows for where changes occur:
        change.rows <- which(character.changes[, "Branch"] == i)
        
        # If there are changes on edge:
        if(length(change.rows) > 0) {
            
            # Compile all changes into edge label:
            edge.labels[i] <- paste(paste(character.changes[change.rows, "Character"], ": ", character.changes[change.rows, "From"], " -> ", character.changes[change.rows, "To"], sep = ""), collapse = "\n")
            
        }
        
    }
    
    # ADD DOT DOT DOT.....
    
    # Plot tree:
    plot(tree, direction = "upwards")
    
    # Add edge labels for changes:
    edgelabels(text = edge.labels, bg = "white", cex = 0.3)

# NEED TO LADDERISE LEFT IF WRITING ON RIGHT OF BRANCHES...

}
