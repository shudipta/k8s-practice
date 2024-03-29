#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname ${BASH_SOURCE})/..
CODEGEN_PKG=${CODEGEN_PKG:-$(cd ${SCRIPT_ROOT}; ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}

# generate the code with:
# --output-base    because this script should also be able to run inside the vendor dir of
#                  k8s.io/kubernetes. The output-base is needed for the generators to output into the vendor dir
#                  instead of the $GOPATH directly. For normal projects this can be dropped.
#echo ">>>>>>>> SCRIPT_ROOT = " $SCRIPT_ROOT
#echo ">>>>>>>> CODEGEN_PKG = " $CODEGEN_PKG
${CODEGEN_PKG}/generate-groups.sh "deepcopy,client,informer,lister" \
  github.com/shudipta/k8s-practice/sample-crd-controller/pkg/client github.com/shudipta/k8s-practice/sample-crd-controller/pkg/apis \
  samplecrdcontroller.crd.com:v1alpha1

#--output-base "$(dirname ${BASH_SOURCE})/../../.."

# To use your own boilerplate text append:
#   --go-header-file ${SCRIPT_ROOT}/hack/custom-boilerplate.go.txt
