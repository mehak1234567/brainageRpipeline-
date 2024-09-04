## brainageRpipeline

The pipeline offers an efficient script to run target NIfTI files through the brainageR machine learning model and output biological brain age. The script processes subject data files and calculates predictions outputting them into organized directories. 
brainageR 


**brainageR Software & Prereqs**
Read the brainageR readme to download required software, dependencies and learn more about the model: 
https://github.com/james-cole/brainageR


**Pipeline Prereqs**
- Must have only one NIfTI (.nii) files in the folder specifies in subject_list 
- Specify the top directory (TOP_DIR) in the script 
- Specify subject_list: List of all subject IDs ina  text files 
- Specify top level directory path in TOP_DIR variable, raw level directory path in RAW_DIR variable, output level directory path in OUTPUT_DIR variable 
- Name raw and output files as “raw” and “output” within the RAW_DIR and OUTPUT_DIR path directories

**Usage**

Once the prerequisites are installed, you can run the pipeline shell script with the following command: 
./process_sample.sh 


**Output**

- Individual subject outputs, including predicted biological age, tissue volumes and DICOM images, are output within the output folder mapped within TOP_DIR to OUTPUT_DIR 
- All output biological brain age is combined in combined_output file within RAW_DIR
- Registry to image templates 
- Each output subject id slidesdir (FSL output), the age, tissues volumes (SPM12 output)

  
**Flags**

-h | –help denotes the help flag, reiterating parts of this readme 


**Testing Cases**

Store a single target NIfTI MRI image in the specified subject directory, either of the following cases can be handled: 
- Single target NIfTI MRI image stored with the naming convention “2_T1_.nii” 
- Single target NIfTI MRI image stored without naming convention still containing “T1.nii”
Else if multiple target images are found, or none at all, respective eros will be outputted. 
