datap=read.csv('PhysicalRelation.csv')
head(datap)
attributes = c('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','SysResponse')
predictor_count = length(attributes)-1
i = 1
repeat{
  print(paste('#####################################ROUND ', i))
  train = datap[1:40, attributes]
  predictors = as.vector( setdiff(attributes, c('SysResponse')) )

  RHS = paste( predictors, collapse = '+')
  LHS = 'SysResponse~'
  print(paste('Formula: ', paste(LHS,RHS)) )
  frmla = as.formula( paste(LHS,RHS) )

  pfit = lm(frmla, data=train) 
  #print( summary(pfit) )

  pvals = summary(pfit)$coefficients[,4] 
  coef_pvals = pvals[2:length(pvals)] #intercept excluded
  if( max(coef_pvals) < 0.05 ){
    break
  } else {
 #   print( coef_pvals )
    maxp_val = as.numeric(coef_pvals[coef_pvals == max(coef_pvals)])
    maxp_attribute = names( coef_pvals[coef_pvals == max(coef_pvals)] )
    print( paste("Drop the attribute ", c(maxp_attribute), " p-value=", maxp_val ) )
	attributes = setdiff(attributes, c(maxp_attribute))
#    print( attributes )
  }
  
  if(i > predictor_count){break} else {i = i + 1}

}
print(paste("List of selected attributes: ", paste(attributes[1:(length(attributes)-1)], collapse=', ') ) ) 
