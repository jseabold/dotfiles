# Hard code US repo for CRAN
r <- getOption("repos")
r["CRAN"] <- "https://cran.rstudio.com"

options(repos = r,
        stringsAsFactors = FALSE)
rm(r)

options(prompt="R> ", digits=4, show.signif.stars=FALSE, "pdfviewer"="okular",
        error=utils::dump.frames)

# have command history available. requires adding
# R_HISTFILE=~/.Rhistory
# to .bashrc
.Last <- function() {
        if (!any(commandArgs()=='--no-readline') && interactive()){
                require(utils)
                try(savehistory(Sys.getenv("R_HISTFILE")))
        }
}
