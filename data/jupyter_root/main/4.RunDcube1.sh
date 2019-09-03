DCUBE_PATH=/data/jupyter_root/dcube_data/
DCUBE_INPUT_PATH=$DCUBE_PATH
DCUBE_OUTPUT_PATH=$DCUBE_PATH
P='1.0' 
K='3'   # number of block
N=$1    # number of input files
rm -rf ${DCUBE_PATH}feature*/
for((i=1;i<=N;i++))
do
    for((P=1;P<=1;P++))
    do
        mkdir -p ${DCUBE_PATH}feature${i}/test${P}
	# read the first line of the input file, and count ','---> dimensions of dcube
	D=$(head -n 1 ${DCUBE_PATH}/feature${i}.txt | grep -o ',' | wc -l)
	# run decube
        /root/DCube-1.0/run_single.sh ${DCUBE_PATH}/feature${i}.txt ${DCUBE_PATH}/feature${i}/test${P} ${D} geo density  ${K} &
        # combine blocks to 'blocks.txt'
        # cat ${DCUBE_PATH}/feature${i}/test${P}/block_*.tuples > ${DCUBE_PATH}/feature${i}/test${P}/blocks.txt
    done
done
echo "Over,run $N times!"
