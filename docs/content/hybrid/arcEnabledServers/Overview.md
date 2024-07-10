---
title: Arc-enabled Servers Overview
geekdocNav: true
geekdocAlign: left
geekdocAnchor: true
geekdocCollapseSection: true
---


Arc-enabled servers are those systems outside of Azure on which you have installed the Azure Connected machine Agent. By installing this agent and connecting it to Azure, you are enabling the management of these systems through the Azure control plane--called Azure Resource Manager. With Azure now aware of your machines, you have the option to manage all your machines on and off Azure with the same tools, in addition to streamlining aspects of machine and application configuration.

## Which Arc features should I use?

With the above capabilities added to their Arc-enabled machines, customers frequently want to know which Arc features they should be using. See the list of [Supported cloud operations](https://learn.microsoft.com/azure/azure-arc/servers/overview#supported-cloud-operations) to get an idea of the categories and features available to Arc-enabled servers.

Regarding cost, consider that while it is free to install the Arc agent and connect to Azure, you may incur additional expense based on the Arc features you use. Review this article for a [list of 'included' and 'paid' features](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-cost-governance#how-much-does-azure-arc-enabled-servers-cost). With cost in mind, consider that many of Arc's features may already be being addressed in your non-Azure environment by other tools which you'll want to evaluate against Arc, both on features and cost. Lastly, when you enable some paid features of Arc, others may be included under the initial monthly charge. See the [Pricing Calculator](https://azure.microsoft.com/pricing/details/azure-arc/core-control-plane/) for more details.

To help move this phase along, we offer the following guidance:

1. **Specific Scenarios**: if there is a specific reason you are deploying Arc, such as [ESUs](./ESU.md) or [Update Management](./UpdateManagement.md), focus on deploying the agents and implementing that feature. You can always circle back on enabling or configuring additional features later.
1. **Feature Evaluations**: if you are thinking about implementing Arc, or are doing it already for a specific reason as above, but also interested in other features available to you, we recommend that you start your evaluation with the [Jumpstart Arcbox project](https://azurearcjumpstart.io/azure_jumpstart_arcbox/). This project enables you to quickly test and evaluate many features in an Azure-based test environment, without worrying about impacting production. If your Azure environment is relatively locked down by Azure Policy or limited RBAC roles, you might consider this testing for a sandbox subscription or Visual Studio Subscription.

## How do I deploy Azure Arc?

At its base, deployment of the Azure Connected machine Agent involves three simple steps:

1. Download the agent installer to the target system
1. Install the agent on the target system
1. Connect the installed agent to Azure

How you perform these steps depends on your environment and scale. For one-off scenarios, you can manually perform all steps. However, as you'll see when you do, a manual deployment is difficult to scale--specifically because you'd need to authenticate to Azure to connect each Arc-enabled server to Azure.

To deploy agents at scale, you'll want to avoid having to authenticate to Azure for each agent. To do this, you'll create an Entra Service Principal and grant it permissions to onboard Arc agents for you, then use that identity across your environment. See this list of [onboarding methods](https://learn.microsoft.com/azure/azure-arc/servers/deployment-options) for detailed guidance, including pre-built deployment automation for a number of configuration management tools.

## Agent networking considerations

There are a number of ways for your Azure Connected machine Agent to reach Azure, including over the internet, through a proxy, or over VPN or ExpressRoute when combined with Private Endpoints. In all cases, you'll need to ensure that your agents are able to access the required ports and URLs in Azure.

For more details on networking options, see:

- [Network topology and connectivity for Azure Arc-enabled servers](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity)
- [Arc Private Endpoint configuration](https://learn.microsoft.com/azure/azure-arc/servers/private-link-security)

For customers considering Private Endpoints, note that there will still be public endpoints required for Arc to function. See this [list of URLs](https://learn.microsoft.com/azure/azure-arc/network-requirements-consolidated?tabs=azure-cloud#urls) and the 'Endpoint used with private link' column. Also, as of this writing, if you are considering using Azure Stack HCI in your environment, note that it does not support Arc Private Endpoints--requiring messy DNS workaround you may want to avoid in the short term.

## Troubleshooting

See [Arc agent overview](https://learn.microsoft.com/en-us/azure/azure-arc/servers/agent-overview) for details on troubleshooting Arc agents and extensions.

## Next Steps

- [Extended Security Updates](./ESU.md)
- [Update Management](./UpdateManagement.md)