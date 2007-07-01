From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/16] libata-link: separate out ata_eh_handle_dev_fail()
Date: Sun, 1 Jul 2007 19:05:58 +0900
Message-ID: <11832843582930-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:51779 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbXGAKGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879666wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:03 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_eh_handle_dev_fail() from ata_eh_recover().  This is
in preparation of ata_link and PMP support.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   96 +++++++++++++++++++++++++---------------------
 1 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1c8f465..5e82231 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2008,6 +2008,57 @@ static int ata_eh_skip_recovery(struct ata_port *ap)
 	return 1;
 }
 
+static void ata_eh_handle_dev_fail(struct ata_device *dev, int err)
+{
+	struct ata_port *ap = dev->ap;
+	struct ata_eh_context *ehc = &ap->eh_context;
+
+	ehc->tries[dev->devno]--;
+
+	switch (err) {
+	case -ENODEV:
+		/* device missing or wrong IDENTIFY data, schedule probing */
+		ehc->i.probe_mask |= (1 << dev->devno);
+	case -EINVAL:
+		/* give it just one more chance */
+		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
+	case -EIO:
+		if (ehc->tries[dev->devno] == 1) {
+			/* This is the last chance, better to slow
+			 * down than lose it.
+			 */
+			sata_down_spd_limit(ap);
+			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
+		}
+	}
+
+	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
+		/* disable device if it has used up all its chances */
+		ata_dev_disable(dev);
+
+		/* detach if offline */
+		if (ata_port_offline(ap))
+			ata_eh_detach_dev(dev);
+
+		/* probe if requested */
+		if ((ehc->i.probe_mask & (1 << dev->devno)) &&
+		    !(ehc->did_probe_mask & (1 << dev->devno))) {
+			ata_eh_detach_dev(dev);
+			ata_dev_init(dev);
+
+			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+			ehc->did_probe_mask |= (1 << dev->devno);
+			ehc->i.action |= ATA_EH_SOFTRESET;
+		}
+	} else {
+		/* soft didn't work?  be haaaaard */
+		if (ehc->i.flags & ATA_EHI_DID_RESET)
+			ehc->i.action |= ATA_EH_HARDRESET;
+		else
+			ehc->i.action |= ATA_EH_SOFTRESET;
+	}
+}
+
 /**
  *	ata_eh_recover - recover host port after error
  *	@ap: host port to recover
@@ -2108,50 +2159,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	goto out;
 
  dev_fail:
-	ehc->tries[dev->devno]--;
-
-	switch (rc) {
-	case -ENODEV:
-		/* device missing or wrong IDENTIFY data, schedule probing */
-		ehc->i.probe_mask |= (1 << dev->devno);
-	case -EINVAL:
-		/* give it just one more chance */
-		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
-	case -EIO:
-		if (ehc->tries[dev->devno] == 1) {
-			/* This is the last chance, better to slow
-			 * down than lose it.
-			 */
-			sata_down_spd_limit(ap);
-			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
-		}
-	}
-
-	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
-		/* disable device if it has used up all its chances */
-		ata_dev_disable(dev);
-
-		/* detach if offline */
-		if (ata_port_offline(ap))
-			ata_eh_detach_dev(dev);
-
-		/* probe if requested */
-		if ((ehc->i.probe_mask & (1 << dev->devno)) &&
-		    !(ehc->did_probe_mask & (1 << dev->devno))) {
-			ata_eh_detach_dev(dev);
-			ata_dev_init(dev);
-
-			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
-			ehc->did_probe_mask |= (1 << dev->devno);
-			ehc->i.action |= ATA_EH_SOFTRESET;
-		}
-	} else {
-		/* soft didn't work?  be haaaaard */
-		if (ehc->i.flags & ATA_EHI_DID_RESET)
-			ehc->i.action |= ATA_EH_HARDRESET;
-		else
-			ehc->i.action |= ATA_EH_SOFTRESET;
-	}
+	ata_eh_handle_dev_fail(dev, rc);
 
 	if (ata_port_nr_enabled(ap)) {
 		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
-- 
1.5.0.3


