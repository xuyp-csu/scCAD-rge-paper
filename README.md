# scCAD-regenerate-figures
Materials (source data & R code) for reproduction of published figures in the main manuscript and supplemental materials of scCAD.

## Projects introduction
```
|
|
|____Demo.ipynb ---  An example of using scCAD to analyze Jurkat dataset, including expected outputs and results presentation for each step.
|
|
|____Demo_res   ---  A folder containing the output results of analyzing the Jurkat dataset using scCAD.
|
|
|____Rplots     ---  A folder containing all the code to regenerate figures in the paper and supplementary materials, along with the source data files.
|
|
|________1. Benchmarking                                   Benchmarking: comparing scCAD with ten state-of-the-art methods in 25 real datasets.
|                                                          Fig. 2 & Supplementary Fig. 1, 2
|
|________2. Decomposition effectively                      Decomposition effectively isolates clusters dominated by rare cell types. 
|                                                          Fig. 3 & Supplementary Fig. 3~9
|
|________3. Robustness test                                Evaluation of robustness and sensitivity of scCAD.
|                                                          Fig. 4
|
|________4. Airway dataset analysis                        scCAD enables the identification of rare airway epithelial cell types.
|                                                          Fig. 5 & Supplementary Fig. 10
|
|________5. Arc-ME dataset analysis                        scCAD identifies various rare cell subpopulations within the mouse brain.
|                                                          Fig. 6 & Supplementary Fig. 11
|
|________6. intestine dataset analysis                     scCAD identifies various rare cell types in the crypts of the irradiated mouse intestine.
|                                                          Fig. 7
|
|________7. pancreas dataset analysis                      scCAD identifies various rare cell types in the human pancreas.            
|                                                          Fig. 8 & Supplementary Fig. 12
|
|________8. immunological datasets analysis                scCAD can identify known rare cell types in large-scale immunological single-cell datasets.
|                                                          Fig. 9
|
|________9. ccRCC datasets analysis                        scCAD identifies various unannotated rare cell subtypes in the clear cell renal cell carcinoma dataset.  
|                                                          Fig. 10 & Supplementary Fig. 13
|
|________10. PBMCs datasets analysis                       scCAD identifies rare cell types in four real PBMC datasets (PBMC-bench-1, 2, 3, and PBMC-test).
|                                                          Supplementary Fig. 14~17
|
|________11. Retina & B_lymphoma datasets analysis         scCAD identifies rare cell types and subtypes in Retina & B_lymphoma datasets.
|                                                          Fig. 11
|
|________12. Parameters test                               Parameter value selection in scCAD.     
|                                                          Supplementary Fig. 18~19
|
|________13. UMAP vs tSNE                                  Comparing t-SNE and UMAP for visualizing rare cell types.
                                                           Supplementary Fig. 20
```

## Notes when running codes
* Make sure the folder structure of the whole project is not changed.
* Modify the homedir variable to change the working directory, aiming to make sure the code can run properly on your machine. 


