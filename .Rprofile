# Hard code US repo for CRAN
r <- getOption("repos")
r["CRAN"] <- "http://cran.us.r-project.org"
options(repos = r)
rm(r)

options(prompt="R> ", digits=4, show.signif.stars=FALSE)

options("pdfviewer"="okular")

# have command history available. requires adding
# R_HISTFILE=~/.Rhistory
# to .bashrc
.Last <- function() {
        if (!any(commandArgs()=='--no-readline') && interactive()){
                require(utils)
                try(savehistory(Sys.getenv("R_HISTFILE")))
        }
}
