From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/8] libata: factor out ata_eh_schedule_probe()
Date: Fri,  2 Nov 2007 00:51:39 +0900
Message-ID: <11939323054018-git-send-email-htejun@gmail.com>
References: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20825 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbXKAPvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:47 -0400
In-Reply-To: <11939323042554-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Factor out ata_eh_schedule_probe() from ata_eh_handle_dev_fail() and
ata_eh_recover().  This is to improve maintainability and make future
changes easier.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ded44bd..6280eae 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2418,6 +2418,22 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 	return 1;
 }
 
+static int ata_eh_schedule_probe(struct ata_device *dev)
+{
+	struct ata_eh_context *ehc = &dev->link->eh_context;
+
+	if (!(ehc->i.probe_mask & (1 << dev->devno)) ||
+	    (ehc->did_probe_mask & (1 << dev->devno)))
+		return 0;
+
+	ata_eh_detach_dev(dev);
+	ata_dev_init(dev);
+	ehc->did_probe_mask |= (1 << dev->devno);
+	ehc->i.action |= ATA_EH_SOFTRESET;
+
+	return 1;
+}
+
 static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
@@ -2449,16 +2465,9 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 		if (ata_link_offline(dev->link))
 			ata_eh_detach_dev(dev);
 
-		/* probe if requested */
-		if ((ehc->i.probe_mask & (1 << dev->devno)) &&
-		    !(ehc->did_probe_mask & (1 << dev->devno))) {
-			ata_eh_detach_dev(dev);
-			ata_dev_init(dev);
-
+		/* schedule probe if necessary */
+		if (ata_eh_schedule_probe(dev))
 			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
-			ehc->did_probe_mask |= (1 << dev->devno);
-			ehc->i.action |= ATA_EH_SOFTRESET;
-		}
 
 		return 1;
 	} else {
@@ -2535,14 +2544,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			if (dev->flags & ATA_DFLAG_DETACH)
 				ata_eh_detach_dev(dev);
 
-			if (!ata_dev_enabled(dev) &&
-			    ((ehc->i.probe_mask & (1 << dev->devno)) &&
-			     !(ehc->did_probe_mask & (1 << dev->devno)))) {
-				ata_eh_detach_dev(dev);
-				ata_dev_init(dev);
-				ehc->did_probe_mask |= (1 << dev->devno);
-				ehc->i.action |= ATA_EH_SOFTRESET;
-			}
+			/* schedule probe if necessary */
+			ata_eh_schedule_probe(dev);
 		}
 	}
 
-- 
1.5.2.4

