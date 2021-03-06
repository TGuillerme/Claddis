#' Prunes a character matrix of characters or taxa
#' 
#' Prunes a character matrix of characters, taxa, or both.
#' 
#' Removing characters or taxa from a matrix imported using \link{ReadMorphNexus} is not simple due to associated vectors for ordering, character weights etc. To save repetitively pruning each part this function takes the matrix as input and vectors of either taxon names, character numbers, or both and removes those from the matrix. Minimum and maximum values (used by \link{MorphDistMatrix}) are also updated.
#' 
#' @param clad.matrix The cladistic matrix in the format imported by \link{ReadMorphNexus}.
#' @param taxa2prune A vector of taxon names to prune (these must be present in \code{rownames(clad.matrix$matrix}).
#' @param characters2prune A vector of character numbers to prune.
#'
#' @author Graeme T. Lloyd \email{graemetlloyd@@gmail.com}
#'
#' @seealso \link{ReadMorphNexus}
#'
#' @keywords NEXUS
#'
#' @examples
#' 
#' # Remove the outgroup taxon and characters 11 and 53 from Gauthier1986:
#' prunedmatrix <- MatrixPruner(clad.matrix = Gauthier1986, taxa2prune = c("Outgroup"),
#'   characters2prune = c(11, 53))
#' 
#' @export MatrixPruner
MatrixPruner <- function(clad.matrix, taxa2prune = c(), characters2prune = c()) {

# ADD OPTION TO REMOVE CONSTANT CHARACTERS

    # Check that something to prune has been specified:
    if(is.null(taxa2prune) && is.null(characters2prune)) stop("No taxa or characters to prune specified.")

    # Check taxa to prune have names matching those in matrix:
    if(length(setdiff(taxa2prune, rownames(clad.matrix$matrix))) > 0) stop("Taxa specified that are not found in the matrix. Check spelling.")

    # Check character numbers are present in matrix:
    if(length(setdiff(characters2prune, c(1:ncol(clad.matrix$matrix))))) stop("Character numbers specified that are not found in the matrix.")

    # If there are taxa to prune, then prune them:
    if(!is.null(taxa2prune)) clad.matrix$matrix <- clad.matrix$matrix[-match(taxa2prune, rownames(clad.matrix$matrix)), , drop = FALSE]

    # If there are characters to prune:
    if(!is.null(characters2prune)) {
        
        # Remove from matrix
        clad.matrix$matrix <- clad.matrix$matrix[, -characters2prune, drop = FALSE]
        
        # Remove from ordering:
        clad.matrix$ordering <- clad.matrix$ordering[-characters2prune]
        
        # Remove from weights:
        clad.matrix$weights <- clad.matrix$weights[-characters2prune]
        
        # Remove from maximum values:
        clad.matrix$max.vals <- clad.matrix$max.vals[-characters2prune]
        
        # Remove from minimum values:
        clad.matrix$min.vals <- clad.matrix$min.vals[-characters2prune]
        
    }
    
    # Get unique values for each character:
    unique.values <- lapply(lapply(lapply(lapply(lapply(lapply(lapply(apply(clad.matrix$matrix, 2, list), unlist), as.character), strsplit, split = "&"), unlist), sort), unique), as.numeric)
    
    # If any character is now all missing data:
    if(length(which(unlist(lapply(unique.values, length)) == 0)) > 0) {
        
        # For each such character insert a single zero:
        for(i in which(unlist(lapply(unique.values, length)) == 0)) unique.values[[i]] <- c(0)
        
    }
    
    # Update maximum values (post pruning):
    clad.matrix$max.vals <- unlist(lapply(unique.values, max))
    
    # Update minimum values (post pruning):
    clad.matrix$min.vals <- unlist(lapply(unique.values, min))

    # Return pruned matrix:
    return(clad.matrix)

}
