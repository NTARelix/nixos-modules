{ pkgs, ... }:
let
  pupSrc = pkgs.datadog-pup.src;
  skillNames = [
    "dd-apm"
    "dd-code-generation"
    "dd-debugger"
    "dd-docs"
    "dd-file-issue"
    "dd-logs"
    "dd-monitors"
    "dd-pup"
    "dd-symdb"
    "dd-triage-flaky-test"
    "dd-unblock-pr"
  ];
  agentNames = [
    "agentless-scanning"
    "api-management"
    "apm-configuration"
    "app-builder"
    "application-security"
    "audience-management"
    "audit-logs"
    "aws-integration"
    "azure-integration"
    "case-management"
    "cicd"
    "cloud-cost"
    "cloud-workload-security"
    "container-monitoring"
    "dashboards"
    "database-monitoring"
    "data-deletion"
    "data-governance"
    "error-tracking"
    "events"
    "fleet-automation"
    "gcp-integration"
    "incident-response"
    "infrastructure"
    "kafka"
    "log-configuration"
    "logs"
    "metrics"
    "monitoring-alerting"
    "network-performance"
    "notebooks"
    "observability-pipelines"
    "organization-management"
    "powerpacks"
    "rum"
    "rum-metrics-retention"
    "saml-configuration"
    "scorecards"
    "security"
    "security-posture-management"
    "service-catalog"
    "slos"
    "spark-pod-autosizing"
    "static-analysis"
    "synthetics"
    "third-party-integrations"
    "traces"
    "usage-metering"
    "user-access-management"
    "workflows"
  ];
in
{
  environment.systemPackages = with pkgs; [ datadog-pup ];
  systemd.tmpfiles.rules =
    (map (
      name: "L+ /home/nixos/.claude/skills/${name} - - - - ${pupSrc}/skills/${name}"
    ) skillNames)
    ++ (map (
      name: "L+ /home/nixos/.claude/agents/${name}.md - - - - ${pupSrc}/agents/${name}.md"
    ) agentNames);
}
