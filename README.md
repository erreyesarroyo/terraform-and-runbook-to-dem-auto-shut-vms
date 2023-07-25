Lessons learned:
command to access official stuff: az cloud set --name azureusgovernment 
Error on official environment
Error returning the VMs: 'this.Client.SubscriptionId' cannot be null.



# terraform-and-runbook-to-dem-auto-shut-vms

High level steps:

-Run the terraform scripts provided to generate your environment. This are very simple scripts just to meet the testing scope. 

-Open an automation account on the aprropriate subscription and do not run as account since we are using a managed id. 

-Import the following modules under share resources, browse the gallery and search and import one at a time: Az.Accounts and Az.Compute. Modules is on shared resources on the modules blade. 

-System assigned status should be on from creation. And, select subscription ->IAM ->  (on the top) _> + role assignment and follow the wizard to virtual machine contributor azure role assignment virtual machine contributor. I added Clasic VVirtual Machine Contributor and Virtual Machine contributor for good measure. The scope is also critical and may be address here or and on the script.

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





