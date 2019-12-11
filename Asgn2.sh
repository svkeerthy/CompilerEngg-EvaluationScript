#!/bin/bash
#-eu
# DIR=${1:-`pwd`}

LLVM_SRC=/home/utpal/llvm
LLVM_BUILD=/home/utpal/build/release_90
TEST_CASES=/home/utpal/Q2-Evaluation/test
LLI=$LLVM_BUILD/bin/lli
#ASSIGN_DIR=/home/utpal/Assignment2
#ASSIGN_DIR=$1

function Options () {
  echo
  echo "Usage: $0 -c path [OPTIONS]"
  echo
  echo "OPTIONS:"
  echo "  -h|?         : Display Options"
  echo "  -i           : Generate LLVM IR"
  echo "  -r           : Run test cases"
  echo "  -c Path      : Compile LoopReversal. Needs a path"
  echo
}


function compileLoopReversal() {
  rm -f "${LLVM_SRC}"/include/llvm/Transforms/LoopReversal/*
  rm -f "${LLVM_SRC}"/lib/Transforms/LoopReversal/*
  rm -f "${LLVM_BUILD}"/lib/LoopReversal.so
  rm -f "${LLVM_BUILD}"/lib64/LoopReversal.so

  if [ -d "$ASSIGN_DIR/llvm/lib/Transforms/LoopReversal" ]; then
    echo "Copy $ASSIGN_DIR/llvm/lib/Transforms/LoopReversal into $LLVM_SRC/lib/Transforms/LoopReversal"
    cp $ASSIGN_DIR/llvm/lib/Transforms/LoopReversal/* "${LLVM_SRC}/lib/Transforms/LoopReversal"
  #if [ -d "$ASSIGN_DIR" ]; then
  #  echo "Copy $ASSIGN_DIR/*.cpp into $LLVM_SRC/lib/Transforms/LoopReversal"
  #  find $ASSIGN_DIR -type f -name "*.cpp" -o -name "*.txt" -exec cp {} $LLVM_SRC/lib/Transforms/LoopReversal \;
  else
    echo "Directory structure not followed"
    exit 1
  fi

  if [ -d "$ASSIGN_DIR/llvm/include/llvm/Transforms/LoopReversal" ]; then
    echo "Copy $ASSIGN_DIR/llvm/include/llvm/Transforms/LoopReversal into $LLVM_SRC/llvm/include/llvm/Transforms/LoopReversal"
    cp $ASSIGN_DIR/llvm/include/llvm/Transforms/LoopReversal/*.h "${LLVM_SRC}/include/llvm/Transforms/LoopReversal/"
  fi

  ninja -j72 -C "${LLVM_BUILD}" LoopReversal
}


function generateIR() {
  cd "${TEST_CASES}"
  for f in `find . -name "*.c"`; do
    out=`basename $f .c`.ll
    "${LLVM_BUILD}"/bin/clang \
      -S -emit-llvm \
      -Xclang -disable-O0-optnone \
      -o $out \
      $f;
    "${LLVM_BUILD}"/bin/opt \
      -S -mem2reg \
      -o $out \
      $out;
    echo $f
  done
}


function runTest() {
  cd "${TEST_CASES}"
  total=0
  while :
  do
    echo "Press [CTRL+C] to stop.."

    echo "Testcase number[1-17]: "
    read file

    echo "======================CASES FROM test$file.c============================"
    sed -e '1,/\/\/=======================================================/d' test$file.c
    echo "========================================================================"

    "${LLVM_BUILD}"/bin/opt \
      -load "${LLVM_BUILD}"/lib64/LoopReversal.so \
      -loop-reversal -S \
      test$file.ll -o test${file}.r.ll

    echo test$file.ll
    ref=`$LLI test$file.ll`
    echo $ref
    echo test$file.r.ll
    rotate=`$LLI test$file.r.ll`
    echo $rotate

    ref=${ref:-"0"}
    rotate=${rotate:-"1"}
    if [ $ref -eq $rotate ]; then
      diff test$file.ll test$file.r.ll
      #"${LLVM_BUILD}"/bin/opt \
      #  -view-cfg test$file.ll
      #"${LLVM_BUILD}"/bin/opt \
      #  -view-cfg test${file}.r.ll

      if ! cmp -s test$file.ll test$file.r.ll; then
        echo "Pass: Test $file passed"
        total=`echo $total + 1 | bc`
      else
        echo "Fail: Test $file failed because no transformation done"
      fi
    else
      echo "Fail: Test $file failed"
    fi

    echo "Do you want to see the test case code? (y/N)"
    read response
    if [ "$response" = "y" ]
    then
      echo "======================test$file.c============================"
      sed '/\/\/=======================================================/Q' test$file.c
      echo "============================================================="
    fi

    echo "Cumulative score = $total"
    rm -f test${file}.r.ll
    echo "Test $file done"
  done
}

while getopts ":c:rih?" optname; do
  case $optname in
    i)
      generateIR;;
    c)
      if [ -d "$OPTARG" ]; then
        ASSIGN_DIR="$OPTARG";
      else
        echo "Provide a valid path to Source";
        Options && exit 1;
      fi
      compileLoopReversal;;
    r)
      runTest;;
    :)
      echo "Invalid option: $OPTARG requires a path" 1>&2
      ;;
    h) ;&
    \?) ;&
    *)
      Options;;
  esac
done
shift $((OPTIND -1))
