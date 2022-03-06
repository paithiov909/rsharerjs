#' Available sharers
#' @examples
#' sharers
#' @export
sharers <- c(
  "twitter",
  "facebook",
  "linkedin",
  "email",
  "whatsapp",
  "telegram",
  "viber",
  "pinterest",
  "tumblr",
  "hackernews",
  "reddit",
  "vk.com",
  "buffer",
  "xing",
  "line",
  "instapapaer",
  "pocket",
  "flipboard",
  "weibo",
  "blogger",
  "baidu",
  "ok.ru",
  "evernote",
  "skype",
  "trello"
)

#' Create social share buttons
#'
#' Create social share buttons for R Markdown or Shiny.
#'
#' @param url url string to share.
#' @param title title string to share.
#' @param media sharers to set as widget.
#' @param width width of widget's wrapper.
#' @param height width of widget's height.
#' @inherit htmlwidgets::createWidget return
#' @import htmlwidgets
#' @importFrom rlang arg_match
#' @export
social_btns <- function(url,
                        title,
                        media = c(
                          "twitter",
                          "facebook",
                          "reddit"
                        ),
                        width = NULL,
                        height = "4.25em") {
  media <- rlang::arg_match(media,
    values = sharers,
    multiple = TRUE
  )

  # forward options using x
  x <- list(
    url = url,
    title = title,
    media = media
  )

  # create widget
  htmlwidgets::createWidget(
    name = "sharer",
    x,
    width = width,
    height = height,
    package = "rsharerjs",
  )
}

#' Shiny bindings for sharer
#'
#' Output and render functions for using sharer within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a sharer
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#' @name sharer-shiny
#' @export
sharerOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "sharer", width, height, package = "sharerjs")
}

#' @rdname sharer-shiny
#' @export
renderSharer <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, sharerOutput, env, quoted = TRUE)
}
