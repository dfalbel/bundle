% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bundle_h2o.R
\name{bundle.H2OAutoML}
\alias{bundle.H2OAutoML}
\alias{bundle.H2OMultinomialModel}
\alias{bundle.H2OBinomialModel}
\alias{bundle.H2ORegressionModel}
\title{Bundle an \code{h2o} object}
\usage{
\method{bundle}{H2OAutoML}(x, id = NULL, n = NULL, ...)

\method{bundle}{H2OMultinomialModel}(x, ...)

\method{bundle}{H2OBinomialModel}(x, ...)

\method{bundle}{H2ORegressionModel}(x, ...)
}
\arguments{
\item{x}{An object returned from modeling functions in the \link[h2o:h2o-package]{h2o}
package.}

\item{id}{A single character. The \code{model_id} entry in the leaderboard.
Applies to AutoML output only. Supply only one of this argument or
\code{n}.}

\item{n}{An integer giving the position in the leaderboard of the model
to bundle. Applies to AutoML output only. Will be ignored if \code{id} is
supplied.}

\item{...}{Not used in this bundler and included for compatibility with
the generic only. Additional arguments passed to this method will return
an error.}
}
\value{
A bundle object with subclass \code{bundled_h2o}.

Bundles are a list subclass with two components:

\item{object}{An R object. Gives the output of native serialization
methods from the model-supplying package, sometimes with additional
classes or attributes that aid portability. This is often
a \link[base:raw]{raw} object.}
\item{situate}{A function. The \code{situate()} function is defined when
\code{\link[=bundle]{bundle()}} is called, though is a loose analogue of an \code{\link[=unbundle]{unbundle()}} S3
method for that object. Since the function is defined on \code{\link[=bundle]{bundle()}}, it
has access to references and dependency information that can
be saved alongside the \code{object} component. Calling \code{\link[=unbundle]{unbundle()}} on a
bundled object \code{x} calls \code{x$situate(x$object)}, returning the
unserialized version of \code{object}. \code{situate()} will also restore needed
references, such as server instances and environmental variables.}

Bundles are R objects that represent a "standalone" version of their
analogous model object. Thus, bundles are ready for saving to file---saving
with \code{\link[base:readRDS]{base::saveRDS()}} is our recommended serialization strategy for bundles,
unless documented otherwise for a specific method.

To restore the inputted model object \code{x} in a new environment, load its
bundle with \code{\link[base:readRDS]{base::readRDS()}} and run \code{\link[=unbundle]{unbundle()}} on it. The output
of \code{\link[=unbundle]{unbundle()}} is a model object that is ready to \code{\link[=predict]{predict()}} on new data,
and other restored functionality (like plotting or summarizing) is supported
as a side effect only.

See \code{vignette("bundle")} for more information on bundling and its motivation.
}
\description{
Bundling a model prepares it to be saved to file and later
restored for prediction in a new R session. See the 'Value' section for
more information on bundles and their usage.
}
\examples{
\dontshow{if (rlang::is_installed("h2o") && rlang::is_installed("MASS")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# fit model and bundle ------------------------------------------------
library(h2o)

set.seed(1)

h2o.init()

cars_h2o <- as.h2o(mtcars)

cars_fit <-
  h2o.glm(
    x = colnames(cars_h2o)[2:11],
    y = colnames(cars_h2o)[1],
    training_frame = cars_h2o
  )

cars_bundle <- bundle(cars_fit)

# then, after saveRDS + readRDS or passing to a new session ----------
cars_unbundled <- unbundle(cars_fit)

predict(cars_unbundled, cars_h2o[, 2:11])

h2o.shutdown()
\dontshow{\}) # examplesIf}
}
\seealso{
These methods wrap \code{\link[h2o:h2o.save_mojo]{h2o::h2o.save_mojo()}} and
\code{\link[h2o:h2o.saveModel]{h2o::h2o.saveModel()}}.

Other bundlers: 
\code{\link{bundle.keras.engine.training.Model}()},
\code{\link{bundle.luz_module_fitted}()},
\code{\link{bundle.model_fit}()},
\code{\link{bundle.recipe}()},
\code{\link{bundle.step_umap}()},
\code{\link{bundle.train}()},
\code{\link{bundle.workflow}()},
\code{\link{bundle.xgb.Booster}()},
\code{\link{bundle}()}
}
\concept{bundlers}
