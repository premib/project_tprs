#!/bin/bash

export PATH=$HOME/project_network/bin:$PATH
export FABRIC_CFG_PATH=$PWD
export SYS_CHANNEL="byfn-sys-channel"
export CHANNEL_NAME=mychannel

#creates certs for univ network
echo "#######################################################"
echo "#creates certs for univ network"
echo "#######################################################"
cryptogen generate --config=./crypto-config.yaml

#create genesis block for channnel
echo "#######################################################"
echo "#create genesis block for channnel"
echo "#######################################################"
configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

#create channel with $CHANNEL_NAME
echo "#######################################################"
echo "#create channel with $CHANNEL_NAME"
echo "#######################################################"
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME



#configure university 1's anchor peer to channel name
echo "#######################################################"
echo "#configure university 1's anchor peer to channel name"
echo "#######################################################"
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Univ1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Univ1MSP

#configure unviersity 2's anchor peer to channel name
echo "#######################################################"
echo "#configure unviersity 2's anchor peer to channel name"
echo "#######################################################"
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Univ2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Univ2MSP



#ca_keys
export BYFN_CA1_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/univ1.results.com/ca && ls *_sk)
export BYFN_CA2_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/univ2.results.com/ca && ls *_sk)

#Run necessary containers
echo "#######################################################"
echo "Starting containers"
echo "#######################################################"
docker-compose -f docker-compose-cli.yaml up -d

#run cli 
#docker-compose exec -it cli bash

#runnin containers
echo "#######################################################"
echo "Running containers"
echo "#######################################################"
docker ps -a --format '{{.ID}}\t\t{{.Names}}'

