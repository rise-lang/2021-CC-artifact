#!/bin/sh
MLIR_BIN="/home/lib/mlir/bin"
MLIR_LIB="/home/lib/mlir/lib"

rise_mm='rise_mm_1024.mlir rise_mm_1x784_784x128.mlir'
affine_mm='affine_mm_1024.mlir affine_mm_1x784_784x128.mlir'
scf_mm='scf_mm_1024.mlir scf_mm_1x784_784x128.mlir'

conv_sizes='128 256 512 1024 2048 4096'

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

# dump compilation breakdown
echo "${GREEN}\nevaluating rise_mm_1024.mlir opt compilation time${NC}"
     $MLIR_BIN/mlir-opt /home/expr/mm/rise_mm_1024.mlir -pass-timing -pass-timing-display=list -convert-rise-to-imperative -convert-linalg-to-loops -affine-loop-tile="tile-sizes=32,16" -affine-vectorize -lower-affine -convert-scf-to-std -convert-std-to-llvm -canonicalize > /dev/null 2> /home/results/compilation_breakdown.txt

# run matrix multiplications
for expr in $rise_mm; do
     echo "${GREEN}\nevaluating ${expr}${NC}"
     $MLIR_BIN/mlir-opt /home/expr/mm/$expr -convert-rise-to-imperative -convert-linalg-to-loops -lower-affine -convert-scf-to-std -convert-std-to-llvm | $MLIR_BIN/mlir-cpu-runner -e mm_test -entry-point-result=void -O3 -shared-libs=$MLIR_LIB/libmlir_runner_utils.so,/home/lib/support_lib/support_lib.so > /dev/null 2> /home/results/mm/${expr}_times
done

for expr in $rise_mm; do
     echo "${GREEN}\nevaluating ${expr} opt ${NC}"
     $MLIR_BIN/mlir-opt /home/expr/mm/$expr -convert-rise-to-imperative -convert-linalg-to-loops -affine-loop-tile="tile-sizes=32,16" -affine-vectorize -lower-affine -convert-scf-to-std -convert-std-to-llvm -canonicalize | $MLIR_BIN/mlir-translate -mlir-to-llvmir | lli -load $MLIR_LIB/libmlir_runner_utils.so -load /home/lib/support_lib/support_lib.so > /dev/null 2> /home/results/mm/${expr}_opt_times
done

for expr in $affine_mm; do
     echo "${GREEN}\nevaluating ${expr}${NC}"
     $MLIR_BIN/mlir-opt -affine-loop-tile="tile-sizes=32,16" -affine-vectorize -lower-affine -convert-scf-to-std -convert-std-to-llvm -canonicalize /home/expr/mm/$expr | $MLIR_BIN/mlir-translate -mlir-to-llvmir | lli -load $MLIR_LIB/libmlir_runner_utils.so -load /home/lib/support_lib/support_lib.so > /dev/null 2> /home/results/mm/${expr}_times
done

for expr in $scf_mm; do
     echo "${GREEN}\nevaluating ${expr}${NC}"
     $MLIR_BIN/mlir-opt -lower-affine -convert-scf-to-std -convert-std-to-llvm -canonicalize /home/expr/mm/$expr | $MLIR_BIN/mlir-translate -mlir-to-llvmir | lli -load $MLIR_LIB/libmlir_runner_utils.so -load /home/lib/support_lib/support_lib.so > /dev/null 2> /home/results/mm/${expr}_times
done

# run convolutions
for size in $conv_sizes; do
     expr=conv_$size.mlir
     echo "${GREEN}\nevaluating ${expr}${NC}"
     $MLIR_BIN/mlir-opt -convert-rise-to-imperative -convert-linalg-to-loops -lower-affine -convert-scf-to-std -convert-std-to-llvm -canonicalize /home/expr/convolution/$expr | $MLIR_BIN/mlir-translate -mlir-to-llvmir | lli -load $MLIR_LIB/libmlir_runner_utils.so -load /home/lib/support_lib/support_lib.so > /dev/null 2> /home/results/convolution/${expr}_times

     exprSep=separated_conv_$size.mlir
     echo "${GREEN}\nevaluating ${exprSep}${NC}"
     $MLIR_BIN/mlir-opt -convert-rise-to-imperative -convert-linalg-to-loops -lower-affine -convert-scf-to-std -convert-std-to-llvm -canonicalize /home/expr/convolution/$exprSep | $MLIR_BIN/mlir-translate -mlir-to-llvmir | lli -load $MLIR_LIB/libmlir_runner_utils.so -load /home/lib/support_lib/support_lib.so > /dev/null 2> /home/results/convolution/${exprSep}_times
done

# processing results
cd results
Rscript process_results.r
echo "${GREEN}Write something sensible here${NC}"