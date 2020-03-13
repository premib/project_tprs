#!/bin/bash


CHANNEL_NAME=mychannel
ORDERER_CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/results.com/orderers/orderer.results.com/msp/tlscacerts/tlsca.results.com-cert.pem


#installing chaincode to clg0 univ1
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/users/Admin@univ1.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ1.results.com:7051 \
-e CORE_PEER_LOCALMSPID="Univ1MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/peers/college0.univ1.results.com/tls/ca.crt  \
cli peer chaincode install -n results -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/Results/javascript


#installing chaincode to clg0 univ2 
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/users/Admin@univ2.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ2.results.com:9051  \
-e CORE_PEER_LOCALMSPID="Univ2MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/peers/college0.univ2.results.com/tls/ca.crt \
cli peer chaincode install -n results -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/Results/javascript


#instantiating chaincode to clg0 univ1
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/users/Admin@univ1.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ1.results.com:7051 \
-e CORE_PEER_LOCALMSPID="Univ1MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/peers/college0.univ1.results.com/tls/ca.crt  \
cli peer chaincode instantiate -o orderer.results.com:7050 --tls --cafile $ORDERER_CAFILE -C $CHANNEL_NAME -n results -l node -v 1.0 -c '{"Args":["firstLedger"]}' -P "AND ('Univ1MSP.peer','Univ2MSP.peer')"