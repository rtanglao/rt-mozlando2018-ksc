# see http://rolandtanglao.com/2019/03/31/p1-use-hatching-to-create-fun-infographics-for-tshirts/
# whick links to:
# https://jef.works/art-with-code/portfolio/20190301_hatching/
#' Hatching photo filter
#'
#' @param img matrix representation of black and white image
#' @param N number of points to be used for hatching
#' @param size average size of points
#' @param var variability in size of points
#' @param step step size between shades of grey
#' @param pch point shape (note pch=4 is a hatch but other shapes can be used as well)
#'
#' @examples
#' library(jpeg)
#' ## sample image
#' img <- readJPEG(system.file("img", "Rlogo.jpg", package="jpeg"))[,,1]
#' img <- t(apply(img,2,rev)) ## rotate
#' hatching(img)
#'
hatching <- function(img, N=10000, size=1, var=1, step=0.05, pch=4) {
  
  ## shading layers
  ts <- unique(quantile(img, rev(seq(0, 1, step))))
  ts[ts >= 1] <- 0.99
  ts[ts <= 0] <- 0.01
  
  ## init background
  pos <- which(img < 1, arr.ind=TRUE)
  m <- min(N, nrow(pos))
  vi <- sample(1:nrow(pos), m)
  pos <- pos[vi,]
  ## random point size
  cex <- rnorm(nrow(pos), size, var)
  plot(pos,
       pch=pch,
       col=rgb(0,0,0,0.1),
       cex=cex,
       axes=FALSE,
       xlab=NA,
       ylab=NA
  )
  ## add on shading layers
  invisible(lapply(ts, function(t) {
    pos <- which(img < t, arr.ind=TRUE)
    m <- min(N, nrow(pos))
    vi <- sample(1:nrow(pos), m)
    pos <- pos[vi,]
    cex <- rnorm(nrow(pos), size, var)
    points(pos,
           pch=pch,
           col=rgb(0,0,0,0.1),
           cex=cex
    )
  }))
}