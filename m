From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: improve probe failure handling
Date: Fri, 2 Feb 2007 16:09:30 +0900
Message-ID: <11704001703111-git-send-email-htejun@gmail.com>
References: <11704001701015-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:48540 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423166AbXBBHJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:09:36 -0500
Received: by wx-out-0506.google.com with SMTP id h31so810585wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:09:36 -0800 (PST)
In-Reply-To: <11704001701015-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* Move forcing device to PIO0 on device disable into
  ata_dev_disable().  This makes both old and new EHs act the same
  way.

* Speed down only PIO mode on probe failure.  All commands used during
  probing are PIO commands.  There's no point in speeding down DMA.

* Retry at least once after -ENODEV.  Some devices report garbled
  IDENTIFY data after certain events.  This shouldn't cause device
  detach and re-attach.

* Rearrange EH failure path for simplicity.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   39 +++++++++++++++++++--------------------
 drivers/ata/libata-eh.c   |   35 ++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 417394b..cbd4bf1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -596,6 +596,8 @@ void ata_dev_disable(struct ata_device *dev)
 {
 	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
 		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
+		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 |
+					     ATA_DNXFER_QUIET);
 		dev->class++;
 	}
 }
@@ -1745,9 +1747,8 @@ int ata_bus_probe(struct ata_port *ap)
 {
 	unsigned int classes[ATA_MAX_DEVICES];
 	int tries[ATA_MAX_DEVICES];
-	int i, rc, down_xfermask;
+	int i, rc;
 	struct ata_device *dev;
-	int dnxfer_sel;
 
 	ata_port_probe(ap);
 
@@ -1755,8 +1756,6 @@ int ata_bus_probe(struct ata_port *ap)
 		tries[i] = ATA_PROBE_MAX_TRIES;
 
  retry:
-	down_xfermask = 0;
-
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
@@ -1804,10 +1803,8 @@ int ata_bus_probe(struct ata_port *ap)
 
 	/* configure transfer mode */
 	rc = ata_set_mode(ap, &dev);
-	if (rc) {
-		down_xfermask = 1;
+	if (rc)
 		goto fail;
-	}
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		if (ata_dev_enabled(&ap->device[i]))
@@ -1819,27 +1816,29 @@ int ata_bus_probe(struct ata_port *ap)
 	return -ENODEV;
 
  fail:
+	tries[dev->devno]--;
+
 	switch (rc) {
 	case -EINVAL:
-	case -ENODEV:
+		/* eeek, something went very wrong, give up */
 		tries[dev->devno] = 0;
 		break;
+
+	case -ENODEV:
+		/* give it just one more chance */
+		tries[dev->devno] = min(tries[dev->devno], 1);
 	case -EIO:
-		sata_down_spd_limit(ap);
-		/* fall through */
-	default:
-		tries[dev->devno]--;
-		dnxfer_sel = ATA_DNXFER_ANY;
-		if (tries[dev->devno] == 1)
-			dnxfer_sel = ATA_DNXFER_FORCE_PIO0;
-		if (down_xfermask && ata_down_xfermask_limit(dev, dnxfer_sel))
-			tries[dev->devno] = 0;
+		if (tries[dev->devno] == 1) {
+			/* This is the last chance, better to slow
+			 * down than lose it.
+			 */
+			sata_down_spd_limit(ap);
+			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
+		}
 	}
 
-	if (!tries[dev->devno]) {
-		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0);
+	if (!tries[dev->devno])
 		ata_dev_disable(dev);
-	}
 
 	goto retry;
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7b61562..1abfdba 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1964,8 +1964,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	struct ata_device *dev;
-	int down_xfermask, i, rc;
-	int dnxfer_sel;
+	int i, rc;
 
 	DPRINTK("ENTER\n");
 
@@ -1994,7 +1993,6 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	}
 
  retry:
-	down_xfermask = 0;
 	rc = 0;
 
 	/* if UNLOADING, finish immediately */
@@ -2039,10 +2037,8 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	/* configure transfer mode if necessary */
 	if (ehc->i.flags & ATA_EHI_SETMODE) {
 		rc = ata_set_mode(ap, &dev);
-		if (rc) {
-			down_xfermask = 1;
+		if (rc)
 			goto dev_fail;
-		}
 		ehc->i.flags &= ~ATA_EHI_SETMODE;
 	}
 
@@ -2054,22 +2050,27 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	goto out;
 
  dev_fail:
+	ehc->tries[dev->devno]--;
+
 	switch (rc) {
-	case -ENODEV:
-		/* device missing, schedule probing */
-		ehc->i.probe_mask |= (1 << dev->devno);
 	case -EINVAL:
+		/* eeek, something went very wrong, give up */
 		ehc->tries[dev->devno] = 0;
 		break;
+
+	case -ENODEV:
+		/* device missing or wrong IDENTIFY data, schedule probing */
+		ehc->i.probe_mask |= (1 << dev->devno);
+		/* give it just one more chance */
+		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
 	case -EIO:
-		sata_down_spd_limit(ap);
-	default:
-		ehc->tries[dev->devno]--;
-		dnxfer_sel = ATA_DNXFER_ANY;
-		if (ehc->tries[dev->devno] == 1)
-			dnxfer_sel = ATA_DNXFER_FORCE_PIO0;
-		if (down_xfermask && ata_down_xfermask_limit(dev, dnxfer_sel))
-			ehc->tries[dev->devno] = 0;
+		if (ehc->tries[dev->devno] == 1) {
+			/* This is the last chance, better to slow
+			 * down than lose it.
+			 */
+			sata_down_spd_limit(ap);
+			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
+		}
 	}
 
 	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
-- 
1.4.4.4


