#!/bin/bash
echo "⚠️ WARNING: Tearing down cloud architecture to freeze billing metrics..."
terraform destroy --auto-approve
echo "✅ Cost Mitigation Complete. Cloud resources set to $0/hr active burn rate."