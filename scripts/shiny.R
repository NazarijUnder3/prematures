library(shiny)

# Define UI ----
ui <- fluidPage(
  titlePanel("Прогноз наличия неврологических нарушений")
           , fluidRow (
                column (3
                  , radioButtons("gestation", "Срок гестации",
                          choices = list("[22; 28]" = "[22; 28]"
                                         , "(28; 31]" = "(28; 31]"
                                         , "(31; 33]" = "(31; 33]"
                                         , "(33; 36]" = "(33; 36]"
                                         )
                          , selected = "[22; 28]")
                        )
                , column (3
                    , radioButtons("alv", "Длительность нахождения на ИВЛ",
                          choices = list("нет" = "нет"
                                         , "[1,7)" = "[1,7)"
                                         , "[7,14)" = "[7,14)"
                                         , "[14,21)" = "[14,21)"
                                         , "[21,30)" = "[21,30)"
                                         , "[30,66]" = "[30,66]"
                          )
                          , selected = "нет")
                        )
                , column (3
                      , radioButtons("apnoe", "АСН на 7 сутки",
                          choices = list("нет" = "нет"
                                         , "да" = "да"
                                         , "СС" = "СС"
                          )
                          , selected = "нет")
                        )
                , column (3
                      , radioButtons("sepsis", "ВУИ, сепсис",
                          choices = list("нет" = "нет"
                                         , "ВУИ" = "ВУИ"
                                         , "ВУИ, сепсис" = "ВУИ, сепсис"
                          )
                          , selected = "нет")
                          )
                  )
           , fluidRow(
                column (3
                      , radioButtons("dn", "Степень ДН",
                          choices = list("нет" = "нет"
                                         , "1" = "1"
                                         , "2" = "2"
                                         , "3" = "3"
                          )
                          , selected = "нет")
                        )
                , column (3
                      , radioButtons("pvk", "Степень ПВК",
                          choices = list("0" = "0"
                                         , "1" = "1"
                                         , "2" = "2"
                                         , "3" = "3"
                                         , "4" = "4"
                          )
                          , selected = "0")
                        )
                , column (3
                       , radioButtons("wb", "Белое вещество",
                          choices = list("нет" = "нет"
                                         , "СПП" = "СПП"
                                         , "ПВЛ" = "ПВЛ"
                          )
                          , selected = "нет")
                        )
                , column (3
                        , radioButtons("reflex", "Рефлексы",
                          choices = list("соответствуют" = "соответствуют"
                                         , "повышеные" = "повышеные"
                                         , "высокие" = "высокие"
                                         , "угнетение ЦНС" = "угнетение ЦНС"
                          )
                            , selected = "соответствуют")
                          )
                )
           , fluidRow (
                       column(3,
                              checkboxInput("asphyxia", "Асфиксия", value = FALSE))
                       , column(3,
                                checkboxInput("sei", "СЭИ", value = FALSE))
                       , column(3,
                                checkboxInput("efpn", "ЭФПН", value = FALSE))
                       , column(3,
                                checkboxInput("habilitation", "Абилитация", value = FALSE))
                    )
  , hr()
  , h3("Ожидаемый результат:")
  , mainPanel(
    tableOutput("result")
    )
  )

# Define server logic ----
server <- function(input, output, session) {
  require(dplyr, quietly=TRUE)
  require(yardstick, quietly=TRUE)
  
  predict_model = readRDS('G:/GIT/prematures/scripts/model_final.model')
  #gest1 = reactive({input$gestation})
  test = reactive({ y = data.frame('Гестация' = input$gestation
                                   , 'Асфиксия' = ifelse(input$asphyxia,"да","нет")
                                   , 'ИВЛ1' = input$alv
                                   , 'АСН7' = input$apnoe
                                   , 'ВУИ.сепсис' = input$sepsis
                                   , 'СЭИ' = ifelse(input$sei,"да","нет")
                                   , 'ДН.степень' = input$dn
                                   , 'ПВК.степень' = input$pvk
                                   , 'ЭФПН' = ifelse(input$efpn,"да", "нет")
                                   , 'БВ' = input$wb
                                   , 'Абилитация' = ifelse(input$habilitation,"да","нет")
                                   , 'Рефлексы' = input$reflex
                                   )
                    })
  
  #Class Predictions
  pred_class = reactive ({
                          predict(predict_model
                                  , new_data = test()
                                  , type = "class"
                                  )
                        })
  # Class Probabilities
  pred_proba = reactive ({
                          predict(predict_model
                                  , new_data = test()
                                  , type = "prob"
                          )
                        })

  results =  reactive ({
                      a = pred_proba()
                      b = pred_class()
                      x = bind_cols(a, b)
                      colnames(x) = c("Вероятность НН", "Вероятность отсутствия НН", "Наличие НН")
                      x
                      })
  #results = reactive ({c("Вероятность НН", "Вероятность отсутствия НН", "Наличие НН"})
  output$result = renderTable(results())
}

# Run the app ----
shinyApp(ui = ui, server = server)