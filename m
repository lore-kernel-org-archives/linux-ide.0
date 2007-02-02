From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_inic162x: fix a few glitches in hardreset
Date: Fri, 2 Feb 2007 15:29:52 +0900
Message-ID: <20070202062952.GB1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:33726 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423144AbXBBGaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 01:30:05 -0500
Received: by wx-out-0506.google.com with SMTP id h31so802068wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 22:30:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

* Hardreset must not exit without actually performing reset regardless
  of link status.  We're resetting the link after all.

* Minor message update.

* 150ms delay is meaningful iff link is online after reset is
  complete.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index b2a6f77..fad2bd3 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -429,11 +429,6 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class)
 	/* hammer it into sane state */
 	inic_reset_port(port_base);
 
-	if (ata_port_offline(ap)) {
-		*class = ATA_DEV_NONE;
-		return 0;
-	}
-
 	val = readw(idma_ctl);
 	writew(val | IDMA_CTL_RST_ATA, idma_ctl);
 	readw(idma_ctl);	/* flush */
@@ -443,16 +438,17 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class)
 	rc = sata_phy_resume(ap, timing);
 	if (rc) {
 		ata_port_printk(ap, KERN_WARNING, "failed to resume "
-				"link for reset (errno=%d)\n", rc);
+				"link after reset (errno=%d)\n", rc);
 		return rc;
 	}
 
-	msleep(150);
-
 	*class = ATA_DEV_NONE;
 	if (ata_port_online(ap)) {
 		struct ata_taskfile tf;
 
+		/* wait a while before checking status */
+		msleep(150);
+
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			ata_port_printk(ap, KERN_WARNING,
 					"device busy after hardreset\n");
-- 
1.4.4.4

