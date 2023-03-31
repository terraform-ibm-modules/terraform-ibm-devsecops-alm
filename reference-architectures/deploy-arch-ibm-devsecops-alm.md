---
copyright:
  years: 2023
lastupdated: "2023-03-20"

keywords:

subcollection: deployable-reference-architectures

authors:
  - name: Padraic Edwards
  - name: Hua Yuen Hui

version: 1.0

deployment-url: url

docs: https://cloud.ibm.com/docs/solution-guide

image_source: https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm/reference-architectures/diagram-deploy-arch-ibm-devsecops-alm-diagram.svg

related_links:
  - title: 'DevSecOps for IBM Cloud'
    url: 'https://cloud.ibm.com/docs/devsecops?topic=devsecops-cd-devsecops-arch'
    description: 'The DevSecOps reference architecture streamlines compliance and audit-readiness by using building blocks like Tekton task library and toolchain templates.'

use-case: DevOps

industry: Technology

compliance:

content-type: reference-architecture

---

<!--
The following line inserts all the attribute definitions. Don't delete.
-->
{{site.data.keyword.attribute-definition-list}}

# Title
{: #deploy-arch-ibm-devsecops-alm}
{: toc-content-type="reference-architecture"}
{: toc-industry="Technology"}
{: toc-use-case="DevOps"}
{: toc-compliance=""}

The DevSecOps deployable architecture creates a set of DevOps Toolchains and pipelines. DevSecOps uses Continuous Delivery (Git Repos and Issue Tracking, Tekton Pipelines,
DevOps Insights, and Code Risk Analyzer), Secrets Manager, Key Protect, Cloud Object Storage, Container Registry and Vulnerability Advisor. Out of the box, DevSecOps also
leverages popular scanning tools such as SonarQube, GoSec, OWASP Zap (dynamic scan), any unit test framework, and GPG signing. It can also be used with more tools such as
external Git providers and artifact stores. DevSecOps supports hybrid deployments, in particular by using private pipeline workers, and can be interfaced with other
deployment tools such as Satellite Config.



## Architecture diagram
{: #architecture-diagram}

![DevSecOps Application Lifecycle Management Arch Diagram](diagram-deploy-arch-ibm-devsecops-alm-diagram.svg "Architecture diagram for DevSecOps Application Lifecycle Management Deployable Architecture "){: caption="Figure 1. Architecture diagram for a set of DevSecOps CI/CD/CC toolchains using the Continuous Delivery service on IBM Cloud" caption-side="bottom"}

## Design requirements
{: #design-requirements}

![Design requirements for the DevSecOps Application Lifecycle Management](heat-map-deploy-arch-ibm-devsecops-alm.svg "Design requirements"){: caption="Figure 2. Scope of the design requirements" caption-side="bottom"}



## Components
{: #components}

The listing of components and their purpose in the architecture should include what requirement the component meets, what component was chosen for this architecture, the reasons for the choice, and any alternative choices considered. These alternative choices _should_ be components or modules that are tested to swap out.

If the architecture is large and includes several rows of the heat map, consider grouping each row in the design requirements heat map as an H3 section. Include a table for just that row where the caption represents that title. For example, `### Security decisions`. Otherwise, use a single table and now subsections.


| Requirement | Component | Reasons for choice | Alternative choice |
|-------------|-----------|--------------------|--------------------|
|     Continuous Integration Toolchain        |    Toolchain Service       |        The continuous integration toolchain and pipelines tests, scans and builds the deployable artifacts from the application repositories.             |                    |
|     Continuous Deployment Toolchain         |    Toolchain Service       |        The continuous deployment toolchain and pipeline generates all of the evidence and change request summary content. The pipeline deploys the build artifacts to an environment, such as staging or production, and then collects, creates, and uploads all existing log files, evidence, and artifacts to the evidence locker.           |                    |
|     Continuous Compliance Toolchain         |    Toolchain Service       |        The continuous compliance toolchain and pipeline periodically scans the deployed artifacts and their source repositories.            |                    |
{: caption="Table 1. Architecture decisions" caption-side="bottom"}

Note: The caption is required only if you're publishing the reference architecture in IBM Cloud Docs.

If you use callout values for components in the architecture diagram, include the value in the table row and component cell that covers it. This guideline applies only if you're publishing to IBM Cloud Docs.

## Compliance
{: #compliance}

_Optional section._ Feedback from users implies that architects want only the high-level compliance items and links off to control details that team members can review. Include the list of control profiles or compliance audits that this architecture meets. For controls, provide "learn more" links to the control library that is published in the IBM Cloud Docs. For audits, provide information about the compliance item.

## Next steps
{: #next-steps}

Install the DevSecOps Application Lifecycle Management deployable architecture on this infrastructure.
