# CSE284-Wi-24-Group24
This is the Github Repository for the CSE 284 Final Project(Winter'24) by Timothy J Sears and Varun Surapaneni. 
You can find the Project Proposal in the PDF above. 

This Project is mainly divided into 2 parts. 


# PART 1(Custom Admixture Python Code) 

This is implementing our own code to run admixture instead of using the admixture command(admixture INPUT_BED_FILE K) which was used in PS2.
To do this we still implement some of the preporocessing steps from PS2. 
We extract the samples from the CEU, PEL, GWD, ASW, and PUR populations and then use Plink to prerpocess the dataset.
We also used plink to implement LD-Pruning. We generate 2 files from the LD Pruning and use one of the files as an input to the original admixture command. 
This file runs admixture using the tool and we use these outputs as a reference comparison for our code. 
The second file is used by our jupyter notebook(Main_comparision_notebook) to run admixture using our own code. This code is present in the main comparison notebook. 

We first read from the .bed file which is our input and convert it to a genotype matrix so that we can use this data to run computations. The .bed file is a binary file and it's data needs to be read before we can do anything. 
It's format is detailed in this website(https://zzz.bwh.harvard.edu/plink/binary.shtml) and we use this a reference to perform our read operations. 

The second part of this code is the main part which is admixture. We name our function as naive_admixture because there are a lot of factors in admixture which it ignores, it really is a simplified version of the admixture alogrithm. 
This function initially initialises P(allele frequencies) and Q(ancestry proportions) randonmly and iterates to optimize. We use the EM algorithm. The intuition behind EM algorithm is to first create a lower bound of log-likelihood l(θ) and then push the lower bound to increase l(θ). EM algorithm is an iteration algorithm containing two steps for each iteration, called E step and M step. 
We then estimate the ancestry in each iteration(E Stage) and then update the allele freqeuncies(M Stage) accoordingly. We run around 2500 iterations of this algorithm and only update a random 100 values in the matrix.
Updating all of them at once results in their product converging to zero very quickly and then python rounds it down so it doesn't yield anything. 

Feel free to go through our code, there are helpful comments along the way to help you understand. We are still currently in the process of varying our training step and iterations to see which one gives us the best results.That's why we have included multiple admixture plots for now.

# Original admixture results for K=3
These are our preliminary results for K=3 for admixture on the PS2 dataset. 
These are shown below. 
![actual_admix_K=3](https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/73237087/36273489-5d8e-4204-9422-117979f967d3)

# Custom admixture results for K=3 
The following photo contains the results we obtained from our custom admixture script for a different number of iterations and N-limit(number of values in the genotype matrix we update per iteration.) 
![myadmix4](https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/73237087/97a694b4-f286-4048-b5a0-3eb2d26c6ba9)


![myadmix](https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/73237087/781dc1ee-998f-4ccd-9592-0c2c4f8246c5)

As you can see there are some differences. Our implementation only using the EM Algorithm(multiplication of all the probabilities) mentioned in the class but the original tool also uses Quasi-Newton methods to accelerate it's optimization. We run it for more than 2000 iterations in the EM algorithm. Our code also takes significantly longer to run. It usually takes more than an hour for 1000 iterations. 

### PART 2 

# Clinical impact of admixture analysis

Certain cancer types are especially prone to racially based disparities. Breast cancer is known to have a higher incidence in caucasians (possibly due to better screening efforts) and have a higher mortality rate in african americans. We aim to recapitulate these known associations and possibly uncover additional associations with unexpected cancer types. We also hope to show that these racial disparities may exist on a spectrum, where admixted populations show an intermediate level of outcome relative to their constituent ancenstries. To conduct this analysis, we used TCGA: a massive database of over 10k cancer patients of many different tissue types and ethnic backgrounds (though still majority white). TCGA germline data is publically available in de-itentified format here: https://portal.gdc.cancer.gov/ upon reasonable request.

Here, we ran custom ADMIXTURE on these TCGA datasets, and in the future will run our improved ADMIXTURE tool and investigate differences in outcomes between the two.

# BRCA racial disparity analysis
First, let's take a look at the racial makeup of breast cancer (BRCA) patients in TCGA

<img width="999" alt="Screen Shot 2024-03-07 at 12 42 10 PM" src="https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/59899277/71697d40-61e4-498d-bb91-ceba34d085b5">

We can see that this population is mostly European, but there are enough patients of other races to do a progression free survival analysis:

<img width="807" alt="Screen Shot 2024-03-07 at 12 42 19 PM" src="https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/59899277/c3742ff5-dba1-4d5c-b140-4a94fe44389a">

Interestingly, we find that admixed AFR/EUR patients have a slightly worse rate of progression, while European patients do the best overall. 

# PRAD racial disparity analysis
Next, let's look at a new cancer type, prostate cancer (PRAD).

<img width="924" alt="Screen Shot 2024-03-07 at 12 42 27 PM" src="https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/59899277/49fc6cea-f642-47a0-93f8-93218110280e">

Similar to BRCA, we can see that this population is mostly European, but there are also enough patients of other races to do a progression free survival analysis:

<img width="745" alt="Screen Shot 2024-03-07 at 12 42 33 PM" src="https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/59899277/ebcfa33a-b3c5-477b-90d7-8074ad7a5686">

We see that European patients do the worst here. Could it be a clinical or genomic difference?



## Future Work 

1. Further refine the admixture code and see where we can further reduce error. Also make more parameters as inputs to the function so that it can be used easily for other codes.
2. Run results for admixture K=5 and see how the results match up for that as well. Waited on this becuase it takes even longer to run. so debugging is a very time taking process.
3. Run our code on the TCGA dataset and see how well it matches up against the results obtained from that. 








