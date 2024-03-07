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

Feel free to go through our code, there are helpful comments along the way to help you understand. 

# Original admixture results for K=3
These are our preliminary results for K=3 for admixture on the PS2 dataset. 
These are shown below. 
![actual_admix_K=3](https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/73237087/36273489-5d8e-4204-9422-117979f967d3)

# Custom admixture results for K=3 
The following photo contains the results we obtained from our custom admixture script. 

![myadmix](https://github.com/Varunkss/CSE284-Wi-24-Group24/assets/73237087/781dc1ee-998f-4ccd-9592-0c2c4f8246c5)

As you can see there are some differences. Our implementation only using the EM Algorithm(multiplication of all the probabilities) mentioned in the class but the original tool also uses Quasi-Newton methods to accelerate it's optimization. We run it for more than 2000 iterations in the EM algorithm. Our code also takes significantly longer to run. It usually takes more than an hour for 1000 iterations. 

## Future Work for admixture(PART1)

1. Further refine the admixture code and see where we can further reduce error. Also make more parameters as inputs to the function so that it can be used easily for other codes.
2. Run results for admixture K=5 and see how the results match up for that as well. Waited on this becuase it takes even longer to run. so debugging is a very time taking process. 

### PART 2 













