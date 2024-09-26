
## ... see [steps 1 - 4](../readme.md)
## 5. Deploy AzStack HCI using ARM templates

In this example which does not have an accompanying lab it is the configuration Three-node storage switchless, dual link cluster.  This type of deployment uses none automatic IP allocation for the storage networks and a different configuration within the storage networks.  The actual ARM Template is the same but the parameters file is slightly different with a more complex stroage network configuration.

The diagram below shows the connectivity between the node for the storage network, each node had 2 links to each of the other 2 nodes and are connected "back-to-back".

![Three-node storage switchless, dual link](./images/3nodedualmeshswitchless.png)

As mentioned the different between this and a 2 node switchless is in the parameter name "storageNetworkList".  The json below shows this parameter

```json
"storageNetworkList": {
            "value": [
                {
                    "name": "StorageNetwork1",
                    "networkAdapterName": "SMB1",
                    "vlanId": "711",
                    "storageAdapterIPInfo": [
                        {
                            "physicalNode": "???-hci-1",
                            "ipv4Address": "10.0.1.1",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-2",
                            "ipv4Address": "10.0.1.2",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-3",
                            "ipv4Address": "10.0.5.3",
                            "subnetMask": "255.255.255.0"
                        }
                    ]
                },
                {
                    "name": "StorageNetwork2",
                    "networkAdapterName": "SMB2",
                    "vlanId": "711",
                    "storageAdapterIPInfo": [
                        {
                            "physicalNode": "???-hci-1",
                            "ipv4Address": "10.0.2.1",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-2",
                            "ipv4Address": "10.0.2.2",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-3",
                            "ipv4Address": "10.0.4.3",
                            "subnetMask": "255.255.255.0"
                        }
                    ]
                },
                {
                    "name": "StorageNetwork3",
                    "networkAdapterName": "SMB3",
                    "vlanId": "711",
                    "storageAdapterIPInfo": [
                        {
                            "physicalNode": "???-hci-1",
                            "ipv4Address": "10.0.5.1",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-2",
                            "ipv4Address": "10.0.3.2",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-3",
                            "ipv4Address": "10.0.3.3",
                            "subnetMask": "255.255.255.0"
                        }
                    ]
                },
                {
                    "name": "StorageNetwork4",
                    "networkAdapterName": "SMB4",
                    "vlanId": "711",
                    "storageAdapterIPInfo": [
                        {
                            "physicalNode": "???-hci-1",
                            "ipv4Address": "10.0.4.2",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-2",
                            "ipv4Address": "10.0.6.1",
                            "subnetMask": "255.255.255.0"
                        },
                        {
                            "physicalNode": "???-hci-3",
                            "ipv4Address": "10.0.6.3",
                            "subnetMask": "255.255.255.0"
                        }
                    ]
                }
            ]
        },
```
A few things to point out about this are:

- Each of the Storage Network defined are for the same common adapter name across all nodes
- The VLAN for each Storage Network can be the same as these ports are connected back to back, the VLAN is needed as part of the RDMA configuration
- The IP address for each adapter in the Storage Network so no need be be from the same subnet, 2 adapters which are connected back to back so need to be on the same subnet. e.g. smb1 on node 1 and 2 are on the same subnet (10.0.1.0/24) as the are connected to each other, however smb1 on node 3 is on 10.0.3.0/24 that is connect to smb3 on node 1

