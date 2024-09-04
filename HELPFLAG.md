**Help Flag**

**Purpose: BrainageR**
- Calculates the biological brain age and executes analysis 
- command "brainageR -f subj01_T1.nii -o subj01_brain_predicted.age.csv" 

**User To-Do:**
- Only one NIfTI (.nii) file in the folder specified in subject_list 
- Specify the top directory (TOP_DIR) in the script 
- Specify subject_list: List of all subject IDs in a text file 
- Specify top level directory path in TOP_DIR variable, raw level directory path in RAW_DIR variable, output level directory path in OUTPUT_DIR variable
- Name raw and output files as "raw" and "output" within the RAW_DIR and OUTPUT_DIR path directories 

**Output**
- Individual subject outputs, including predicted biological age, tissue volumes and DICOM images, are output within the output folder mapped within TOP_DIR to OUTPUT_DIR
- All output biological brain age is combined in the combined_output file within RAW_DIR 
- Registry to image templates 

**Flag**
- The notation -h|--help displays help message and exits
