From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: improve ata_std_prereset()
Date: Fri, 2 Feb 2007 16:50:52 +0900
Message-ID: <11704026523234-git-send-email-htejun@gmail.com>
References: <11704026511717-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:64800 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423208AbXBBHvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:51:24 -0500
Received: by wx-out-0506.google.com with SMTP id h31so819854wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:51:23 -0800 (PST)
In-Reply-To: <11704026511717-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch updates ata_std_prereset() as follows.

* Don't fail on phy resume failure.  Just whine and continue.  Failure
  from prereset makes libata abort whole reset sequence and give up
  the port, so prereset() should be best effort.  This is more
  important with the coming EH updates as prereset() will be called
  with shorter timeout.

* If ata_wait_ready() fails, whine and request hardreset instead.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ef52beb..03ad181 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2928,7 +2928,11 @@ static void ata_wait_spinup(struct ata_port *ap, unsigned long deadline)
  *	@ap: ATA port to be reset
  *	@deadline: deadline jiffies for the operation
  *
- *	@ap is about to be reset.  Initialize it.
+ *	@ap is about to be reset.  Initialize it.  Failure from
+ *	prereset makes libata abort whole reset sequence and give up
+ *	that port, so prereset should be best-effort.  It does its
+ *	best to prepare for reset sequence but if things go wrong, it
+ *	should just whine, not fail.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2958,19 +2962,23 @@ int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 	/* if SATA, resume phy */
 	if (ap->cbl == ATA_CBL_SATA) {
 		rc = sata_phy_resume(ap, timing, deadline);
-		if (rc && rc != -EOPNOTSUPP) {
-			/* phy resume failed */
+		/* whine about phy resume failure but proceed */
+		if (rc && rc != -EOPNOTSUPP)
 			ata_port_printk(ap, KERN_WARNING, "failed to resume "
 					"link for reset (errno=%d)\n", rc);
-			return rc;
-		}
 	}
 
 	/* Wait for !BSY if the controller can wait for the first D2H
 	 * Reg FIS and we don't know that no device is attached.
 	 */
-	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap))
-		ata_wait_ready(ap, deadline);
+	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap)) {
+		rc = ata_wait_ready(ap, deadline);
+		if (rc) {
+			ata_port_printk(ap, KERN_WARNING, "device not ready "
+					"(errno=%d), forcing hardreset\n", rc);
+			ehc->i.action |= ATA_EH_HARDRESET;
+		}
+	}
 
 	return 0;
 }
-- 
1.4.4.4


