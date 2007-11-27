From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/8] libata: factor out ata_eh_schedule_probe()
Date: Tue, 27 Nov 2007 19:28:54 +0900
Message-ID: <11961593392930-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbXK0K3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1179628wah
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:14 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

Factor out ata_eh_schedule_probe() from ata_eh_handle_dev_fail() and
ata_eh_recover().  This is to improve maintainability and make future
changes easier.

In the previous revision, ata_dev_enabled() test was accidentally
dropped while factoring out.  This problem was spotted by Bartlomiej.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/libata-eh.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c36c837..44c137e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2343,6 +2343,22 @@ static int ata_eh_skip_recovery(struct ata_link *link)
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
@@ -2374,16 +2390,9 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
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
@@ -2460,14 +2469,9 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
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
+			if (!ata_dev_enabled(dev))
+				ata_eh_schedule_probe(dev);
 		}
 	}
 
-- 
1.5.2.4

