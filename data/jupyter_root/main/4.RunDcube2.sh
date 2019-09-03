DCUBE_PATH=/data/jupyter_root/dcube_data/
DCUBE_INPUT_PATH=$DCUBE_PATH
DCUBE_OUTPUT_PATH=$DCUBE_PATH
N=$1    # number of input files
D='3' # dimensions of dcube
rm -rf ${DCUBE_PATH}feature*/
for ((i=1; i<=N; i +=5)) 
do
    mkdir -p ${DCUBE_PATH}feature$(($i))
    mkdir -p ${DCUBE_PATH}feature$(($i+1))
    mkdir -p ${DCUBE_PATH}feature$(($i+2))
    mkdir -p ${DCUBE_PATH}feature$(($i+3))
    mkdir -p ${DCUBE_PATH}feature$(($i+4))  
    # read the first line of the input file, and count ','---> dimensions of dcube
    D1=$(head -n 1 ${DCUBE_PATH}/feature$(($i)).txt | grep -o ',' | wc -l)
    D2=$(head -n 1 ${DCUBE_PATH}/feature$(($i+1)).txt | grep -o ',' | wc -l)
    D3=$(head -n 1 ${DCUBE_PATH}/feature$(($i+2)).txt | grep -o ',' | wc -l)
    D4=$(head -n 1 ${DCUBE_PATH}/feature$(($i+3)).txt | grep -o ',' | wc -l)
    D5=$(head -n 1 ${DCUBE_PATH}/feature$(($i+4)).txt | grep -o ',' | wc -l)

    java -cp ./DCube-1.0.jar dcube.Proposed ${DCUBE_PATH}/feature$(($i)).txt   ${DCUBE_PATH}/feature$(($i)) ${D1} geo density  5 &\
    java -cp ./DCube-1.0.jar dcube.Proposed ${DCUBE_PATH}/feature$(($i+1)).txt ${DCUBE_PATH}/feature$(($i+1)) ${D2} geo density  5 &\
    java -cp ./DCube-1.0.jar dcube.Proposed ${DCUBE_PATH}/feature$(($i+2)).txt ${DCUBE_PATH}/feature$(($i+2)) ${D3} geo density  5 &\
    java -cp ./DCube-1.0.jar dcube.Proposed ${DCUBE_PATH}/feature$(($i+3)).txt ${DCUBE_PATH}/feature$(($i+3)) ${D4} geo density  5 &\
    java -cp ./DCube-1.0.jar dcube.Proposed ${DCUBE_PATH}/feature$(($i+4)).txt ${DCUBE_PATH}/feature$(($i+4)) ${D5} geo density  5 
    wait
done
for((i=1;i<=N;i++))
do
    # combine blocks to 'blocks.txt'
    cat ${DCUBE_PATH}/feature${i}/block_1.tuples   ${DCUBE_PATH}/feature${i}/block_2.tuples > ${DCUBE_PATH}/feature${i}/block12.txt
    cat ${DCUBE_PATH}/feature${i}/block_1.tuples   ${DCUBE_PATH}/feature${i}/block_3.tuples > ${DCUBE_PATH}/feature${i}/block13.txt
    cat ${DCUBE_PATH}/feature${i}/block_2.tuples   ${DCUBE_PATH}/feature${i}/block_3.tuples > ${DCUBE_PATH}/feature${i}/block23.txt
    cat ${DCUBE_PATH}/feature${i}/block_1.tuples   ${DCUBE_PATH}/feature${i}/block_2.tuples ${DCUBE_PATH}/feature${i}/block_3.tuples > ${DCUBE_PATH}/feature${i}/block123.txt
done

echo "Over,run $N times!"
