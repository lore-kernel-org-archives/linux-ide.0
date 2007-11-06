From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/8 UPDATED] libata: factor out ata_eh_schedule_probe()
Date: Tue, 06 Nov 2007 13:53:19 +0900
Message-ID: <472FF33F.1090109@gmail.com>
References: <1194241515653-git-send-email-htejun@gmail.com> <11942415162701-git-send-email-htejun@gmail.com> <200711051136.57793.bzolnier@gmail.com> <472F0CA5.7010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:20716 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbXKFEx3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 23:53:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2270835wah
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 20:53:28 -0800 (PST)
In-Reply-To: <472F0CA5.7010800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Factor out ata_eh_schedule_probe() from ata_eh_handle_dev_fail() and
ata_eh_recover().  This is to improve maintainability and make future
changes easier.

In the previous revision, ata_dev_enabled() test was accidentally
dropped while factoring out.  This problem was spotted by Bartlomiej.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/libata-eh.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2438,6 +2438,22 @@ static int ata_eh_skip_recovery(struct a
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
@@ -2469,16 +2485,9 @@ static int ata_eh_handle_dev_fail(struct
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
@@ -2555,14 +2564,9 @@ int ata_eh_recover(struct ata_port *ap, 
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
 
