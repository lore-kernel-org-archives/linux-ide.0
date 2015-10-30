From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/4] ahci: ahci_host_activate: kill IRQF_SHARED
Date: Fri, 30 Oct 2015 17:09:30 -0400
Message-ID: <20151030210930.8538.95181.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61202 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030348AbbJ3VPM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2015 17:15:12 -0400
In-Reply-To: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

MSI messages are per-device, so there will never be another "shared"
device in the interrupt chain.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d256a66158be..887749916d3e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2486,7 +2486,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 
 		rc = devm_request_threaded_irq(host->dev, irq + i,
 					       ahci_multi_irqs_intr,
-					       ahci_port_thread_fn, IRQF_SHARED,
+					       ahci_port_thread_fn, 0,
 					       pp->irq_desc, host->ports[i]);
 		if (rc)
 			goto out_free_irqs;

