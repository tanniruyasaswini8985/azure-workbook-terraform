{
  "version": "Notebook/1.0",
  "items": [
    {
      "type": 1,
      "name": "intro",
      "content": {
        "json": "## Operations Overview\nEnvironment: **${environment}**. Deployed and managed with Terraform."
      }
    },
    {
      "type": 3,
      "name": "heartbeat",
      "content": {
        "version": "KqlItem/1.0",
        "title": "Agent heartbeat by computer (24h)",
        "query": "Heartbeat | where TimeGenerated > ago(24h) | summarize Heartbeats = count() by bin(TimeGenerated, 1h), Computer | order by TimeGenerated asc",
        "size": 0,
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": ["${workspace_id}"],
        "visualization": "timechart"
      }
    },
    {
      "type": 3,
      "name": "ingestion",
      "content": {
        "version": "KqlItem/1.0",
        "title": "Data ingestion by table (GB, 7 days)",
        "query": "Usage | where TimeGenerated > ago(7d) | summarize IngestedGB = sum(Quantity) / 1024 by DataType | order by IngestedGB desc",
        "size": 0,
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": ["${workspace_id}"],
        "visualization": "barchart"
      }
    },
    {
      "type": 3,
      "name": "failed-operations",
      "content": {
        "version": "KqlItem/1.0",
        "title": "Failed Azure operations (24h)",
        "query": "AzureActivity | where TimeGenerated > ago(24h) | where ActivityStatusValue == 'Failure' | summarize Failures = count() by OperationNameValue | top 10 by Failures desc",
        "size": 0,
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": ["${workspace_id}"],
        "visualization": "table"
      }
    }
  ],
  "fallbackResourceIds": ["${workspace_id}"],
  "$schema": "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
}
