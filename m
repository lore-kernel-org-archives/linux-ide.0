From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH] AHCI: Make distinct names for ports in /proc/interrupts
Date: Mon, 29 Apr 2013 12:12:38 +0200
Message-ID: <20130429101237.GA27738@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab3D2KLS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Apr 2013 06:11:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>

Currently all interrupts assigned to AHCI ports show up in
'/proc/interrupts' as 'ahci'. This fix adds port numbers as
suffixes and hence makes the descriptions distinct.

Reported-by: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/ata/ahci.c |    6 ++++--
 drivers/ata/ahci.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3b9a7b1..dc5c1aa 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1146,10 +1146,12 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis,
 			return -EINVAL;
 
 		for (i = 0; i < n_irqs; i++) {
+			struct ahci_port_priv *pp = host->ports[i]->private_data;
+			snprintf(pp->irq_desc, sizeof(pp->irq_desc),
+				 "%s%d", dev_driver_string(host->dev), i);
 			rc = devm_request_threaded_irq(host->dev, irq + i,
 				ahci_multi_irqs_intr, ahci_port_thread_fn,
-				IRQF_SHARED, dev_driver_string(host->dev),
-				host->ports[i]);
+				IRQF_SHARED, pp->irq_desc, host->ports[i]);
 			if (rc)
 				goto out_free_irqs;
 		}
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index ed1fbc8..ceb5208 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -305,6 +305,7 @@ struct ahci_port_priv {
 	int			fbs_last_dev;	/* save FBS.DEV of last FIS */
 	/* enclosure management info per PM slot */
 	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
+	char			irq_desc[8];	/* bus + port # */
 };
 
 struct ahci_host_priv {
-- 
1.7.7.6


-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
