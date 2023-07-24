az cloud set --name azureusgovernment 

# terraform-and-runbook-to-dem-auto-shut-vms

High level steps:

-Run the terraform scripts provided to generate your environment. This are very simple scripts just to meet the testing scope. 

-Open an automation account on the aprropriate subscription and do not run as account since we are using a managed id. 

-Import the following modules under share resources, browse the gallery and search and import one at a time: Az.Accounts and Az.Compute. Modules is on shared resources on the modules blade. 

-Same blade as wbobe under account settings find identity and enable system assigned status to on. And, select azure role assignments. I added Clasic VVirtual Machine Contributor and Virtual Machine contributor for good measure. The scope is also critical the highest available as 7/23/23 is subscription which will allow for segregation. 

-Select subscription on the main blade or serch on the bar, got to IAM, role assignment right next to check access and you should see the new rbac associate with the account.

-Go to runbooks, runbook typoe will powershell, and copy paste the script. The script is cmmented to describe its parts for more info. Save and click the test pane, it will take min or two.

-Once it works, click on edit and publish

-go back to the runbook->schedules (under resources, on the left blade)

-configure your schedule appropriately. Recommend to start your machine, and schedule the runbook 10 minutes after for good testing measure. 


Lessons Learned:
Ensure the tags in the ps script and the terraform script are the exactly the same. 
Patience. Azure may take a few minutes on personal accounts. 

Next Steps:
-Provission the whole runbook on terraform

Resources:
https://learn.microsoft.com/en-us/azure/automation/automation-solution-vm-management-config
https://learn.microsoft.com/en-us/azure/automation/manage-runbooks
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine





