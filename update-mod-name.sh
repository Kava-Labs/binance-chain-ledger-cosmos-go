#! /bin/bash
set -e

# add a go mod file (auto migrates from dep)
go mod init github.com/kava-labs/binance-chain-ledger-cosmos-go

# Normally would need to up update self-imports, but there aren't any.

# move tendermint imports to kava-labs/tendermint
grep -rl --include=*.go \"github.com/tendermint/tendermint . | xargs sed -i '' 's#"github.com/tendermint/tendermint#"github.com/kava-labs/tendermint#'
go mod edit --droprequire "github.com/tendermint/tendermint" -require "github.com/kava-labs/tendermint@v0.32.3-kava1"
go mod tidy

# remove no longer needed dep files
rm Gopkg.lock Gopkg.toml