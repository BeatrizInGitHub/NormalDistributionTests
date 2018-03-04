library(shiny)
library(shinythemes)
library(shinyCustom)
library(tidyverse)
library(nortest)

server <- function(input, output, session) {
  
  inFile <- reactive({
    inFile <- input$file1
    req(inFile)
    read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  })
  
  observe({
    updateSelectizeInput(
      session,
      "variable",
      choices=names(inFile())
      )
  })
  
  observe({
    updateSelectizeInput(
      session,
      "groupvar",
      choices=names(inFile())
    )
  })
  
  # output$test <- renderPrint({
  #   nums <- sapply(inFile(), is.numeric)
  #   chars <- sapply(inFile(), is.factor)
  #   inNumb<-inFile()[ , nums]
  #   inChar<-inFile()[ , chars]
  #   car<-as.data.frame(inChar)
  #   sq<-as.data.frame(sqrt(inNumb))
  #   df<-cbind(sq,car)
  #   df
  # })
  
  output$dist <- renderPlot({
    
    nums <- sapply(inFile(), is.numeric)
    chars <- sapply(inFile(), is.factor)
    inNumb<-inFile()[ , nums]
    inChar<-inFile()[ , chars]
    car<-as.data.frame(inChar)
    sq<-as.data.frame(sqrt(inNumb))
    cr<-as.data.frame(sign(inNumb) * abs(inNumb)^(1/3))
    lt<-as.data.frame(log(inNumb))
    sqroot<-cbind(sq,car)
    cuberoot<-cbind(cr,car)
    logtrans<-cbind(lt,car)
    
    if (input$gv) {
      if (input$sqt) {
        g<-ggplot(sqroot,aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(aes_string(fill=input$groupvar, alpha=.001)) +
          theme_bw() +
          scale_alpha(guide = 'none') +
          ggtitle("Histogram/Density Estimation")
        print(g)
      } else if (input$cub) {
        g<-ggplot(cuberoot,aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(aes_string(fill=input$groupvar, alpha=.001)) +
          theme_bw() +
          scale_alpha(guide = 'none') +
          ggtitle("Histogram/Density Estimation")
        print(g)
      } else if (input$log) {
        g<-ggplot(logtrans,aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(aes_string(fill=input$groupvar, alpha=.001)) +
          theme_bw() +
          scale_alpha(guide = 'none') +
          ggtitle("Histogram/Density Estimation")
        print(g)
      } else {
        g<-ggplot(inFile(),aes_string(x=input$variable)) + 
                geom_histogram(aes(y=..density..),color="black",binwidth = input$bins, fill="white") +
                geom_density(aes_string(fill=input$groupvar, alpha=.001)) +
                theme_bw() +
                scale_alpha(guide = 'none') +
                ggtitle("Histogram/Density Estimation")
              print(g)
      }
    } else {
      if (input$sqt) {
        g<-ggplot(sqroot,aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(fill="#90C3D4",alpha=.1) +
          theme_bw() +
          ggtitle("Histogram/Density Estimation")
        print(g)
      } else if (input$cub) {
        g<-ggplot(cuberoot,aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(fill="#90C3D4",alpha=.1) +
          theme_bw() +
          ggtitle("Histogram/Density Estimation")
        print(g)
      } else if (input$log) {
        g<-ggplot(logtrans,aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(fill="#90C3D4",alpha=.1) +
          theme_bw() +
          ggtitle("Histogram/Density Estimation")
        print(g)
      } else {
        g<-ggplot(inFile(),aes_string(x=input$variable)) +
          geom_histogram(aes(y=..density..),binwidth = input$bins, colour="black", fill="white") +
          geom_density(alpha= .15, fill="blue") +
          theme_bw() +
          ggtitle("Histogram/Density Estimation")
        print(g)
      }
    }
  })
  
  output$swpval <- renderUI({
    
    nums <- sapply(inFile(), is.numeric)
    chars <- sapply(inFile(), is.factor)
    inNumb<-inFile()[ , nums]
    inChar<-inFile()[ , chars]
    car<-as.data.frame(inChar)
    sq<-as.data.frame(sqrt(inNumb))
    cr<-as.data.frame(sign(inNumb) * abs(inNumb)^(1/3))
    lt<-as.data.frame(log(inNumb))
    sqroot<-cbind(sq,car)
    cuberoot<-cbind(cr,car)
    logtrans<-cbind(lt,car)
    
    if (input$sqt) {
      var1 <- sqroot[,input$variable]
    } else if (input$cub) {
      var1 <- cuberoot[,input$variable]
    } else if (input$log) {
      var1 <- logtrans[,input$variable]
    } else {
      var1 <- inFile()[,input$variable]
    }
    
    sw<-shapiro.test(var1)
    tags$div(
      HTML("<strong>Shapiro-Wilk Test</strong>","<em>p</em>","- value =", format(sw$p.value,digits = 3))
    )
  })

  output$adpval <- renderUI({

    nums <- sapply(inFile(), is.numeric)
    chars <- sapply(inFile(), is.factor)
    inNumb<-inFile()[ , nums]
    inChar<-inFile()[ , chars]
    car<-as.data.frame(inChar)
    sq<-as.data.frame(sqrt(inNumb))
    cr<-as.data.frame(sign(inNumb) * abs(inNumb)^(1/3))
    lt<-as.data.frame(log(inNumb))
    sqroot<-cbind(sq,car)
    cuberoot<-cbind(cr,car)
    logtrans<-cbind(lt,car)
    
    if (input$sqt) {
      var1 <- sqroot[,input$variable]
    } else if (input$cub) {
      var1 <- cuberoot[,input$variable]
    } else if (input$log) {
      var1 <- logtrans[,input$variable]
    } else {
      var1 <- inFile()[,input$variable]
    }
    
    ad<-ad.test(var1)
    tags$div(
      HTML("<strong>Anderson-Darling Test</strong>","<em>p</em>","- value =", format(ad$p.value,digits = 3))
    )
  })
  
  output$qqplot <- renderPlot({
    
    qqnorm_data <- function(x){
      Q <- as.data.frame(qqnorm(x, plot = FALSE))
      names(Q) <- c("xq", substitute(x))
      Q
    }
    
    nums <- sapply(inFile(), is.numeric)
    chars <- sapply(inFile(), is.factor)
    inNumb<-inFile()[ , nums]
    inChar<-inFile()[ , chars]
    car<-as.data.frame(inChar)
    sq<-as.data.frame(sqrt(inNumb))
    cr<-as.data.frame(sign(inNumb) * abs(inNumb)^(1/3))
    lt<-as.data.frame(log(inNumb))
    sqroot<-cbind(sq,car)
    cuberoot<-cbind(cr,car)
    logtrans<-cbind(lt,car)
    
    if (input$sqt) {
      vec <- sqroot[,input$variable]
    } else if (input$cub) {
      vec <- cuberoot[,input$variable]
    } else if (input$log) {
      vec <- logtrans[,input$variable]
    } else {
      vec <- inFile()[,input$variable]
    }
    
    y <- quantile(vec[!is.na(vec)], c(0.25, 0.75))
    x <- qnorm(c(0.25, 0.75))
    slope <- diff(y)/diff(x)
    int <- y[1] - slope * x[1]
    
    if (input$sqt) {
      g<-ggplot(sqroot,aes_string(sample=input$variable)) +
        stat_qq() +
        ggtitle("Normal Quantile-Quantile Plot") +
        theme_bw() +
        geom_abline(slope = slope, intercept = int,color="blue")
      print(g)
    } else if (input$cub) {
      g<-ggplot(cuberoot,aes_string(sample=input$variable)) +
        stat_qq() +
        ggtitle("Normal Quantile-Quantile Plot") +
        theme_bw() +
        geom_abline(slope = slope, intercept = int,color="blue")
      print(g)
    } else if (input$log) {
      g<-ggplot(logtrans,aes_string(sample=input$variable)) +
        stat_qq() +
        ggtitle("Normal Quantile-Quantile Plot") +
        theme_bw() +
        geom_abline(slope = slope, intercept = int,color="blue")
      print(g)
    } else {
      g<-ggplot(inNumb,aes_string(sample=input$variable)) +
        stat_qq() +
        ggtitle("Normal Quantile-Quantile Plot") +
        theme_bw() +
        geom_abline(slope = slope, intercept = int,color="blue")
      print(g)
    }
  })
  
}

ui <- fluidPage(theme = shinytheme("spacelab"),
                tags$style(type="text/css",
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"
                ),
                tags$head(
                  tags$style(HTML("hr {border-top: 3px solid #B8B8B8;}"))
                ),
                titlePanel("Distribution Normality Tests"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      radioButtons('sep', 'Separator:',c(Comma=',',Semicolon=';',Tab='\t'),','),
      checkboxInput('header', 'Header', TRUE),
      selectInput("variable", "Select Variable for Testing",""),
      checkboxInput('gv', 'Use Grouping Variable? (Optional)', F),
      selectInput("groupvar", "Select Grouping Variable",""),
      useShinyCustom(slider_delay = "0"),
      customSliderInput("bins", #Use customSliderInput instead of sliderInput
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 1),
      hr(),
      h3("Apply Transforms"),
      checkboxInput('sqt', 'Square Root', F),
      checkboxInput('cub', 'Cube Root', F),
      checkboxInput('log', 'Log Transform', F),
      # checkboxInput('tuk', 'Tukey’s Ladder of Powers', F),
      hr(),
      h4(uiOutput("swpval")),
      h4(uiOutput("adpval"))
    ),
    mainPanel(
      plotOutput("dist"),
      plotOutput("qqplot")
      # verbatimTextOutput("test")
      )
  )
)

shinyApp(ui = ui, server = server)