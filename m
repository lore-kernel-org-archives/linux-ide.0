From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/4] ahci: cleanup ahci_host_activate_multi_irqs
Date: Fri, 30 Oct 2015 17:09:35 -0400
Message-ID: <20151030210935.8538.54059.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47027 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030348AbbJ3VPS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2015 17:15:18 -0400
In-Reply-To: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

With devm there is no need to explicitly free irqs on error.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libahci.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 887749916d3e..373c7b1602ff 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2489,25 +2489,10 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 					       ahci_port_thread_fn, 0,
 					       pp->irq_desc, host->ports[i]);
 		if (rc)
-			goto out_free_irqs;
-	}
-
-	for (i = 0; i < host->n_ports; i++)
+			return rc;
 		ata_port_desc(host->ports[i], "irq %d", irq + i);
-
-	rc = ata_host_register(host, sht);
-	if (rc)
-		goto out_free_all_irqs;
-
-	return 0;
-
-out_free_all_irqs:
-	i = host->n_ports;
-out_free_irqs:
-	for (i--; i >= 0; i--)
-		devm_free_irq(host->dev, irq + i, host->ports[i]);
-
-	return rc;
+	}
+	return ata_host_register(host, sht);
 }
 
 /**

