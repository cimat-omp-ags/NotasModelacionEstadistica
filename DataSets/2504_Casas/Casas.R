rm(list=ls())

### Instalación

list.of.packages <- c("readxl", "pheatmap", "ggplot2","modeest")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

### Activación

library(readxl)   # Leer el archivo excel
library(pheatmap) # Generar mapa calor
library(ggplot2)  # Graficos ggplot2
library(modeest)  # Moda

Casas <- read_excel("Casas.xlsx")
View(Casas)
attach(Casas)

table(COND)
FactCond <- factor(COND, labels = c("No necesita arreglos", "Necesita arreglos"))
tabla_Condicion = table(FactCond)
tabla_Condicion

table(ZONA)
FactZona = factor(ZONA, labels = c("Zona 1", "Zona 2", "Zona 3"))
tabla_Zona = table(FactZona)
tabla_Zona

# ------------------------------------------------------------------------------
# Condiciones de la casa
barplot(tabla_Condicion,
        main = "Condición de la casa",
        xlab = "Condición",
        ylab = "Frecuencia",
        col = terrain.colors(3))
# ------------------------------------------------------------------------------
# Relación precio zona
boxplot(PRECIO ~ ZONA, 
        main = "Distribución de precios de casas por zona",
        xlab = "Zona",
        ylab = "Precio",
        col = terrain.colors(3))
# ------------------------------------------------------------------------------
# Calcular tendencia central por zona
promedio <- tapply(PRECIO, FactZona, mean)
print("Media:")
print(promedio)

mediana <- tapply(PRECIO, FactZona, median)
print("Mediana:")
print(mediana)

moda <- tapply(PRECIO, FactZona, mlv, method = "shorth")
print("Moda:")
print(moda)
# ------------------------------------------------------------------------------
# Gráficos de dispersión para cada variable numérica
par(mfrow=c(3,2), mar=c(2, 7, 1, 1)) 

plot(RECAM, PRECIO, 
     main = "Precio vs Recámaras",
     xlab = "Cantidad de Recámaras",
     ylab = "Precio",
     col = "#87CEEB",
     pch = 19,
     cex = 0.8)

plot(AREA, PRECIO, 
     main = "Precio vs Área",
     xlab = "Área de construcción",
     ylab = "Precio",
     col = "#87CEAA",
     pch = 19,
     cex = 0.8) 

plot(CUARTOS, PRECIO, 
     main = "Precio vs Cuartos",
     xlab = "Cantidad de cuartos",
     ylab = "Precio",
     col = "#4682B4",
     pch = 19,
     cex = 0.8)

plot(LONGFR, PRECIO, 
     main = "Precio vs Longitud frente",
     xlab = "Longitud de frente (metros)",
     ylab = "Precio",
     col = "#000080",
     pch = 19,
     cex = 0.8)

plot(BAÑOS, PRECIO, 
     main = "Precio vs Baños",
     xlab = "Cantidad de baños",
     ylab = "Precio",
     col = "#191BDB",
     pch = 19,
     cex = 0.8)

plot(COCH, PRECIO, 
     main = "Precio vs Espacio para vehículos",
     xlab = "Cantidad de vehículos",
     ylab = "Precio",
     col = "#41BCB5",
     pch = 19,
     cex = 0.8)

par(mfrow=c(1,1))
# ------------------------------------------------------------------------------
# Gráfico de barras de la variable CHIM
FactChim = factor(CHIM, labels = c("No", "Sí"))
barplot(table(FactChim), 
        main = "Presencia de chimenea", 
        xlab = "Chimenea", 
        ylab = "Frecuencia",
        col = c("#41BCB5", "#4682B4"))

# Gráfico de barras de la variable contraventana
FactContraV = factor(CONTRAV, labels = c("No", "Sí"))
barplot(table(FactContraV), 
        main = "Presencia de contraventanas", 
        xlab = "Contraventana", 
        ylab = "Frecuencia",
        col = c("#000080", "#BFFBDB"))

# Gráfico de barras de la variable tipo de construcción
FactCons = factor(CON, labels = c("Ladrillo", "Tiene madera"))
barplot(table(FactCons), 
        main = "Tipo de construcción", 
        xlab = "Tipo de construcción", 
        ylab = "Frecuencia",
        col = c("#BF9BBF", "#BF9AFF"))

# Gráfico de barras de la variable tipo de construcción
barplot(table(FactZona), 
        main = "Tipo de construcción", 
        xlab = "Tipo de construcción", 
        ylab = "Frecuencia",
        col = c("#BF5DA3", "#B93C57","#E58A30"))
# ------------------------------------------------------------------------------
# Gráfico de dispersión de correlación entre el área de construcción y el precio
plot(AREA, PRECIO, 
     pch = 21, 
     bg = colores[unclass(FactZona)],
     main = "Relación entre área de construcción y precio", 
     xlab = "Área de construcción", 
     ylab = "Precio")

legend("bottomright",
       legend = levels(FactZona),
       fill = colores)
# ------------------------------------------------------------------------------
# Crear un dataframe con los datos
df <- data.frame(PRECIO, AREA, FactZona, RECAM)

# Crear el gráfico utilizando ggplot2
ggplot(df, aes(x =AREA , y = PRECIO, color = FactZona, size = RECAM)) +
  geom_point() +
  labs(title = "Relación entre precio, área, zona y recámaras",
       x = "Área de construcción",
       y = "Precio",
       color = "Zona",
       size = "Recámaras") +
  theme_minimal()

# ------------------------------------------------------------------------------
# Cantidad de baños por cuartos en la casa
FactBAÑOS <- factor(BAÑOS, levels = sort(unique(BAÑOS)))
colores <- rainbow(length(unique(BAÑOS)))
plot(AREA, CUARTOS, 
     pch = 21, 
     bg = colores[unclass(FactBAÑOS)],
     main = "Relación entre cantidad de cuartos, área de construcción y baños",
     xlab = "Área de construcción",
     ylab = "Cuartos")

legend("topleft", 
       legend = levels(FactBAÑOS),
       fill = colores)
# ------------------------------------------------------------------------------
# Relacion precio zona condición de la vivienda
plot(PRECIO, ZONA,
     pch = 21, 
     bg = colores[unclass(FactCond)],
     main = "Relación entre zona, precio y condición de la casa",
     xlab = "Precio",
     ylab = "Zona",
     yaxt = "n")

# Establecer etiquetas personalizadas en el eje x
axis(2, at = c(1, 2, 3), labels = c(1, 2, 3))

legend("topright",
       legend = levels(FactCond),
       fill = colores)
# ------------------------------------------------------------------------------

# Análisis de correlación

# Crear una subconjunto de datos solo con las variables numéricas
datos_numericos <- Casas[, c("RECAM", "AREA","CHIM","CUARTOS","CONTRAV",
                             "LONGFR", "BAÑOS","CON","COCH","COND","ZONA","PRECIO")]

# Calcular la matriz de correlación
matriz_correlacion <- cor(datos_numericos, method = "spearman")
print(matriz_correlacion)

# Mapa de calor
pheatmap(matriz_correlacion, 
         scale = "none",
         display_numbers = TRUE,
         number_color = "black", 
         fontsize_number = 8)

# ------------------------------------------------------------------------------
# Análisis de valores atipicos

boxplot(AREA, 
        main = "Boxplot de Área", 
        ylab = "Área en metros cuadrados", 
        col = "#F8BBD0", 
        border = "black")

boxplot(LONGFR, 
        main = "Boxplot de longitud de frente", 
        ylab = "Longitud de frente en metros", 
        col = "#E2725B", 
        border = "black")

boxplot(RECAM, 
        main = "Boxplot de Recámaras", 
        ylab = "Cantidad de Recámaras", 
        col = "#E9A451", 
        border = "black")

boxplot(CUARTOS, 
        main = "Boxplot de Cuartos", 
        ylab = "Cantidad de Cuartos", 
        col = "#D68FB6", 
        border = "black")

boxplot(BAÑOS, 
        main = "Boxplot de Baños", 
        ylab = "Cantidad de Baños", 
        col = "#9B4F6C", 
        border = "black")

boxplot(COCH, 
        main = "Boxplot de Cochera", 
        ylab = "Capacidad de la cochera", 
        col = "#EAB951", 
        border = "black")

boxplot(ZONA, 
        main = "Boxplot de zona",
        ylab = "Zonas de residencia",
        col = "#E2720F")
# ------------------------------------------------------------------------------
# Modelo completo

modelo_c <- lm(PRECIO ~ RECAM + AREA + CHIM + CUARTOS + CONTRAV + LONGFR  + BAÑOS + CON + COCH + 
                        COND + ZONA, data = Casas)
summary(modelo_c)

# ------------------------------------------------------------------------------
# Modelo 1
modelo_1 <- lm(PRECIO ~ RECAM + AREA  + CHIM + CUARTOS + CONTRAV + LONGFR  + COCH, data = Casas)

# Mostrar un resumen del modelo
summary(modelo_1)

# ------------------------------------------------------------------------------
# Modelo 2
modelo_2 <- lm(PRECIO ~ RECAM + AREA  + CHIM + CUARTOS + CONTRAV + LONGFR, data = Casas)

# Mostrar un resumen del modelo
summary(modelo_2)

modelo_regresion <- lm(PRECIO ~ RECAM + AREA  + CHIM + CUARTOS + CONTRAV + LONGFR, data = Casas)


# ------------------------------------------------------------------------------
# Análisis de residuos
# Prueba de Shapiro-Wilk para normalidad de los residuos
residuos <- modelo_regresion$residuals
shapiro.test(residuos)

# Gráfico de QQ para visualizar la normalidad de los residuos
qqnorm(residuos)
qqline(residuos)

plot(modelo_regresion$fitted.values, 
     residuos, 
     xlab = "Valores Ajustados", 
     ylab = "Residuos", 
     main = "Residuos vs. Valores Ajustados")
abline(h = 0, col = "red")

