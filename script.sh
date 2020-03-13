#!/bin/bash



export FABRIC_CFG_PATH=$PWD
export SYS_CHANNEL="byfn-sys-channel"
export CHANNEL_NAME=mychannel
export ORDERER_CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/results.com/orderers/orderer.results.com/msp/tlscacerts/tlsca.results.com-cert.pem

#creating channel, return channel_name.block
echo "#####################################################################"
echo "#creating channel, return channel_name.block"
echo "#####################################################################"
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/users/Admin@univ1.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ1.results.com:7051 \
-e CORE_PEER_LOCALMSPID="Univ1MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/peers/college0.univ1.results.com/tls/ca.crt  \
cli peer channel create -o orderer.results.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls --cafile $ORDERER_CAFILE
sleep 5


#joining college0 of univ 1 to channel $CHANNEL_NAME
echo "#####################################################################"
echo "#joining college0 of univ 1 to channel $CHANNEL_NAME"
echo "#####################################################################"
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/users/Admin@univ1.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ1.results.com:7051 \
-e CORE_PEER_LOCALMSPID="Univ1MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/peers/college0.univ1.results.com/tls/ca.crt  \
cli peer channel join -b mychannel.block
sleep 5


#joining college0 of univ 2 to channel $CHANNEL_NAME
echo "#####################################################################"
echo "#joining college0 of univ 2 to channel $CHANNEL_NAME"
echo "#####################################################################"
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/users/Admin@univ2.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ2.results.com:9051 \
-e CORE_PEER_LOCALMSPID="Univ2MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/peers/college0.univ2.results.com/tls/ca.crt \
cli peer channel join -b mychannel.block
sleep 5


# #joining  college1 of univ 1 to channel $CHANNEL_NAME
# echo "#####################################################################"
# echo "#joining  college1 of univ 1 to channel $CHANNEL_NAME"
# echo "#####################################################################"
# docker exec \
# -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/users/Admin@univ1.results.com/msp \
# -e CORE_PEER_ADDRESS=college0.univ1.results.com:7051 \
# -e CORE_PEER_LOCALMSPID="Univ1MSP" \
# -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/peers/college0.univ1.results.com/tls/ca.crt \
# cli peer channel join -b mychannel.block
# sleep 5


# #joining college1 of univ 2 to channel $CHANNEL_NAME
# echo "#####################################################################"
# echo "#joining college1 of univ 2 to channel $CHANNEL_NAME"
# echo "#####################################################################"
# docker exec \
# -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/users/Admin@univ2.results.com/msp \
# -e CORE_PEER_ADDRESS=college0.univ2.results.com:9051 \
# -e CORE_PEER_LOCALMSPID="Univ2MSP" \
# -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/peers/college0.univ2.results.com/tls/ca.crt \
# cli peer channel join -b mychannel.block
# sleep 5


#updating college0 of univ 1 as anchor peer to channel $CHANNEL_NAME
echo "#####################################################################"
echo "#updating college0 of univ 1 as anchor peer to channel $CHANNEL_NAME"
echo "#####################################################################"
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/users/Admin@univ1.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ1.results.com:7051 \
-e CORE_PEER_LOCALMSPID="Univ1MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ1.results.com/peers/college0.univ1.results.com/tls/ca.crt  \
cli peer channel update -o orderer.results.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Univ1MSPanchors.tx --tls --cafile $ORDERER_CAFILE
sleep 5


#updating college0 of univ 2 as anchor peer to channel $CHANNEL_NAME
echo "#####################################################################"
echo "#updating college0 of univ 2 as anchor peer to channel $CHANNEL_NAME"
echo "#####################################################################"
docker exec \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/users/Admin@univ2.results.com/msp \
-e CORE_PEER_ADDRESS=college0.univ2.results.com:9051  \
-e CORE_PEER_LOCALMSPID="Univ2MSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/univ2.results.com/peers/college0.univ2.results.com/tls/ca.crt \
cli peer channel update -o orderer.results.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Univ2MSPanchors.tx --tls --cafile $ORDERER_CAFILE

