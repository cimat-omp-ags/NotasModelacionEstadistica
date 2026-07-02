**Do-file para Unidad 2-ARL
**Fecha de elaboración : 2025/04/07
**Fecha de MODIFICACION: 2025/04/09
**Realizado por Humberto Mtz Bta

clear
capture clear
capture log close
set more off



import excel "/Users/humbertomartinezbautista/pCloud Drive/Public Folder/MMOP_24_25/ARL/Casas/Casas.xlsx", sheet("Hoja1") firstrow clear
             
*Conocer cómo stata almacena los datos

describe //

/*Análisis univariado-EDA*/

dtable i.CHIM i.CONTRAV  i.CON  i.COCH i.ZONA, column( summary(Frecuencia (%)) ) nformat(%9.0g  mean) title(Tabla 1. Estadísticos descriptivos) note(Fuente: Elaboración propia) export("Tabla1", as(docx) replace) varlabel   fvlabel


*Grafico de dispersión matricial
 graph matrix PRECIO RECAM AREA CUARTOS LONGFR BAÑOS, half /// 
 title(Dispersión de variables de estudio) ///
 note(Fuente: Elaboración propia) scheme(s1color) ///
 name(Gph_dispersion_matricial, replace)
 

/*
graph box PRECIO, over(CHIM)
graph box PRECIO, over(CONTRAV)
graph box PRECIO, over(CON)
graph box PRECIO, over(COCH)
graph box PRECIO, over(ZONA)
*/
 
 
 *Análisis correlacional (bivariado)
 
 
spearman   PRECIO RECAM AREA CUARTOS LONGFR BAÑOS CHIM CONTRAV  CON  COCH ZONA , stats(rho p) star(0.05) print(0.05) pw

polychoric PRECIO RECAM AREA CUARTOS LONGFR BAÑOS CHIM CONTRAV  CON  COCH ZONA  ,  pw verbose
 
* 
return list
matrix corrmatrix = r(R)
heatplot corrmatrix, values(format(%5.2f) size(tiny)) legend(on) color(hcl diverging, intensity(.9)) aspectratio(1) xlabel(,labsize(tiny) angle(45)) ylabel(,labsize(tiny)) upper nodiagonal cuts(-1(.2)1)
 
 */


*Selección automática (STEPWISE)

stepwise, pr(.15) pe(.10) : regress PRECIO RECAM AREA CUARTOS LONGFR BAÑOS i.CHIM i.CONTRAV  i.CON  i.COCH i.ZONA, baselevels

estat hettes
estat ovtest


*Le ayudo a stepwise quitando RECAM

stepwise, pr(.11) pe(.10) : regress PRECIO  AREA CUARTOS LONGFR BAÑOS i.CHIM i.CONTRAV  i.CON  i.COCH i.ZONA, baselevels //me da un excelente modelo


*regress PRECIO  AREA  LONGFR   i.CONTRAV  i.CON  i.COCH i2.b3.ZONA, baselevels //propuesta HMB
*estimates store HMB

regress PRECIO AREA CUARTOS i.CONTRAV LONGFR RECAM i.CHIM, baselevels //Propuesta 2
estimates store Propuesta2
 
 

 *****SUPUESTOS DEL MODELO GAUSS-MARKOV
 *Linealidad?? resp=Diagramas de dipersión y Pearson
 *Normalidad?? resp=summary, hist, swilks q-q plot
 *Multicolinealidad= Alta correlacion entre las x´s
 estat vif
 *Heteroscedasticidad
 hettest
 
 *Especificación
  estat ovtest
  *linktest   // no lo pasan
 
 
 
  *Residuales
predict residuales, residuals


*Normalidad (OK)
histogram residuales,  norm kdensity
swilk residuales
qnorm residuales
 

*análsis de residuales p=predictoras=X´s
rvfplot, yline(0)
rvpplot AREA
rvpplot LONGFR


 
 
 
 *Comandos de POST-ESTIMACIÓN
  *Residuales
predict restude, rstudent

*Outliers
list  if abs(restude) > 2

 *Leverage
* db predict
 predict lev, leverage
 list if lev>(2*6+2)/26
 lvr2plot, mlabel(Id)
 
 *Puntos de influencia
 predict d, cooksd
 list if d > 4/26
 
 
 
 
*Graph

coefplot (HMB, label(M1: ) mcolor(black) mlabcolor(black) msymbol(d msize(vtiny))  ciopts(color(black) lpattern(solid)) base) ///
         (Propuesta2, label(M2: ) mcolor(blue)  mlabcolor(blue) msymbol(o msize(vtiny)) ciopts(color(blue)  lpattern(solid)) base) ///
, drop(_cons) ///
xtitle(Coeficientes) ///
xlabel(0(20)200) ///
aspect(0) ///
graphregion(fcolor(white)) ///
xlabel(, notick) ///
xline(0, lwidth(medium) lcolor(purple) lpattern(solid)) ///
mlabel( cond(@pval<.001, "***", ///
		cond(@pval<.01, "**", ///
		cond(@pval<.05, "*", ///
		cond(@pval>.05, "", ///
string(@pval,"%9.2f")))))) ///
legend(position(3) ring(0) title("R2 ajustada ", size(*.5)) size(small) ///
   cols(1) region(lwidth(none) fcolor(gs15)) ) ///
mlabposition(2) mlabgap(-0.5) mlabsize(small) /// 
name(EjemploGuiadoAutos, replace)
 
