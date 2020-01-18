# Data-Cleaning

The data set contains historical data of borrowers. The aim is to clean the data.

## Data Dictionary

| Variabl Name	| Description	| Type	| Source |
|---------------|-------------|-------|---------|
|NPA Status|	Person experienced 180 days past due delinquency or worse| 	Y/N|	Based on Personal Loan Portfolio of Lender|
|RevolvingUtilizationOfUnsecuredLines	|Total balance on credit cards and personal lines of credit except real estate and no installment debt like car loans divided by the sum of credit limits	|percentage	|Credit Berau|
|age|	Age of borrower in years|	integer	|Application|
|NumberOfTime30-59DaysPastDueNotWorse|	Number of times borrower has been 30-59 days past due but no worse in the last 2 years	|integer|	Credit Berau|
|DebtRatio|	Monthly debt payments, alimony,living costs divided by monthy gross income|	percentage|	Credit Berau|
|MonthlyIncome|	Monthly income of borrower|	real	|Credit Berau|
|NumberOfOpenCreditLinesAndLoans|	Number of Open loans (installment like car loan or mortgage) and Lines of credit (e.g. credit cards)|	integer|	Credit Berau|
|NumberOfTimes90DaysLate|	Number of times borrower has been 90 days or more past due|	integer|	Credit Berau|
|NumberRealEstateLoansOrLines|	Number of mortgage and real estate loans including home equity lines of credit|	integer|	Credit Berau|
|NumberOfTime60-89DaysPastDueNotWorse|	Number of times borrower has been 60-89 days past due but no worse in the last 2 years|	integer|	Credit Berau|
|NumberOfDependents|	Number of dependents in family excluding themselves (spouse, children etc.)|	integer|	Application|
|Gender|	Gender of borrower|	Character|	Application|
|Region| 	Region based on address given by borrower|	Character|	Application|
|Rented_Ownhouse|	If the borrower lives in a rented space or own house	|Character	|Application|
|Occupation|	Occupation of borrower|	Character|	|Application|
|Education|	Highest Education of borrower	|Character	|Application|
