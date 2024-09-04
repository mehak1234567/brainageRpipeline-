#!/bin/bash

#flags 
function usage() {
    cat <<EOF 
    USAGE: $0 [options]

    Options:
    -h | --help displays this help message and exits

    BrainageR Purpose:
    - Calculates the biological brain age and executes analysis 
    - command "brainageR -f subj01_T1.nii -o subj01_brain_predicted.age.csv" 

    User To-Do:
    - Specify the top directory (TOP_DIR) in the script 
    - Specify subject_list : List of all subject IDs in a text file 

    Output:
    - All output biological brain age is combined in the combined_output file 
    - Registry to image templates 

    Flag:
    - The notation -h|--help displays help message and exits

EOF
    exit 1     
}

while [ "$1" != "" ]; do
    case $1 in
        -h | --help)
        usage 
        ;;
    *)
        echo "invalid option"
        usage
        exit 1 
        ;;
    
    esac
    shift 

done

TOP_DIR="/media/mcuser/Data1/mehaktest"
OUTPUT_DIR="$TOP_DIR/output"
RAW_DIR="$TOP_DIR/raw"
subject_list="$RAW_DIR/file_list.txt"
combined_output="$RAW_DIR/combined_output.csv"
echo "Subject_ID,filename,Predicted_Age,LCI,UCI" > "$combined_output"


for subject_id in $(cat $subject_list); do
    echo "currently processing $subject_id"
    subject_dir="$RAW_DIR/$subject_id"
    target_files=($(find "$subject_dir" -type f -iname '2_*T1*.nii*')) #check if user follows naming convention
    
    if [ -f "$target_files" ]; then 
        echo $target_files
        target_dir=$(dirname $target_files)
        nii_file=$(echo "${target_files[*]}")
        output_dir="$target_dir/${subject_id}_output"
        mkdir -p "$output_dir"
        #echo "$subject_id" > "$subject_dir/file_list.txt"
        output_file="$output_dir/${subject_id}_predicted.age.csv"
        brainageR -f "$nii_file" -o "$output_file"
        echo "Processed $subject_id, stored in $output_dir"
        echo $subject_id","$(cat $output_file | tail -n +2 "$output_file") >> $combined_output

        mod_target_files=$(basename $target_files .nii)
        slicedir_target=$(find "$target_dir" -type d -name "*slicesdir_$mod_target_files*")

        tissuevolumes_target=$(find "$target_dir" -type f -name "*$mod_target_files*_tissue_volumes*.csv*")

        mv "$slicedir_target" "$output_dir"
        mv "$tissuevolumes_target" "$output_dir"

        mv "$output_dir" "$OUTPUT_DIR"

    else #if not find any file w "*T1*.nii*" in name, case-insensitive, limited to one

        matching_files=($(find "$subject_dir" -type f -iname '*T1*.nii*'))
        count=${#matching_files[@]}
        
        if [ "$count" -eq 1 ]; then
            matching_dir=$(dirname "$matching_files")
            echo $matching_files
            nii_file=$(echo "${matching_files[*]}")
            output_dir="$matching_dir/${subject_id}_output"
            mkdir -p "$output_dir"
            #echo "$subject_id" > "$subject_dir/file_list.txt"
            output_file="$output_dir/${subject_id}_predicted.age.csv"
            brainageR -f "$nii_file" -o "$output_file"
            echo "Processed $subject_id, stored in $output_dir"
            echo $subject_id","$(cat $output_file | tail -n +2 "$output_file") >> $combined_output

            mod_matching_files=$(basename $matching_files .nii)
            slicedir_matching=$(find "$matching_dir" -type d -name "*slicesdir_$mod_matching_files*")

            tissuevolumes_matching=$(find "$matching_dir" -type f -name "*$mod_matching_files*_tissue_volumes*.csv*")
    
            mv "$slicedir_matching" "$output_dir"
            mv "$tissuevolumes_matching" "$output_dir"

            mv "$output_dir" "$OUTPUT_DIR"

        elif [ "$count" -gt 1 ]; then #if more than one error
            echo "Error: More than one T1W.nii file found in one $subject_dir for $subject_id"

        else 
            echo "Error: no .nii file found for $subject_id"  
        
        fi
    fi
    echo -e "\n\n"
    

done
echo "All files processed" 



    























