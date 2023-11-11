#!/usr/bin/env bash
# Copyright Amazon.com Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
set -o pipefail

SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

NEWROOT=/go-vuln-check

source $SCRIPT_ROOT/common_vars.sh

function install_go_vuln_check() {
    GO111MODULE=on GOBIN=${NEWROOT}/${GOPATH}/${GOLANG_MAJOR_VERSION}/bin go install golang.org/x/vuln/cmd/govulncheck@$GO_VULN_CHECK_VERSION

    rm -rf ${GOPATH}

    time upx --best --no-lzma ${NEWROOT}/${GOPATH}/${GOLANG_MAJOR_VERSION}/bin/govulncheck
}

[ ${SKIP_INSTALL:-false} != false ] || install_go_vuln_check
