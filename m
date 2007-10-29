From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 1/2] libata: relocate forcing PIO0 on reset
Date: Mon, 29 Oct 2007 16:41:09 +0900
Message-ID: <20071029074109.GO11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:63742 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbXJ2HlT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 03:41:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1494172rvb
        for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 00:41:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Forcing PIO0 on reset was done inside ata_bus_softreset(), which is a
bit out of place as it should be applied to all resets - hard, soft
and implementation which don't use ata_bus_softreset().  Relocate it
such that...

* For new EH, it's done in ata_eh_reset() before calling prereset.

* For old EH, it's done before calling ap->ops->phy_reset() in
  ata_bus_probe().

This makes PIO0 forced after all resets.  Another difference is that
reset itself is done after PIO0 is forced.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-core.c |   46 +++++++++++++++++++---------------------------
 drivers/ata/libata-eh.c   |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 27 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -2219,6 +2219,25 @@ int ata_bus_probe(struct ata_port *ap)
 		tries[dev->devno] = ATA_PROBE_MAX_TRIES;
 
  retry:
+	ata_link_for_each_dev(dev, &ap->link) {
+		/* If we issue an SRST then an ATA drive (not ATAPI)
+		 * may change configuration and be in PIO0 timing. If
+		 * we do a hard reset (or are coming from power on)
+		 * this is true for ATA or ATAPI. Until we've set a
+		 * suitable controller mode we should not touch the
+		 * bus as we may be talking too fast.
+		 */
+		dev->pio_mode = XFER_PIO_0;
+
+		/* If the controller has a pio mode setup function
+		 * then use it to set the chipset to rights. Don't
+		 * touch the DMA setup as that will be dealt with when
+		 * configuring devices.
+		 */
+		if (ap->ops->set_piomode)
+			ap->ops->set_piomode(ap, dev);
+	}
+
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
@@ -2234,12 +2253,6 @@ int ata_bus_probe(struct ata_port *ap)
 
 	ata_port_probe(ap);
 
-	/* after the reset the device state is PIO 0 and the controller
-	   state is undefined. Record the mode */
-
-	ata_link_for_each_dev(dev, &ap->link)
-		dev->pio_mode = XFER_PIO_0;
-
 	/* read IDENTIFY page and configure devices. We have to do the identify
 	   specific sequence bass-ackwards so that PDIAG- is released by
 	   the slave device */
@@ -3272,8 +3285,6 @@ static int ata_bus_softreset(struct ata_
 			     unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	struct ata_device *dev;
-	int i = 0;
 
 	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
 
@@ -3284,25 +3295,6 @@ static int ata_bus_softreset(struct ata_
 	udelay(20);	/* FIXME: flush */
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
-	/* If we issued an SRST then an ATA drive (not ATAPI)
-	 * may have changed configuration and be in PIO0 timing. If
-	 * we did a hard reset (or are coming from power on) this is
-	 * true for ATA or ATAPI. Until we've set a suitable controller
-	 * mode we should not touch the bus as we may be talking too fast.
-	 */
-
-	ata_link_for_each_dev(dev, &ap->link)
-		dev->pio_mode = XFER_PIO_0;
-
-	/* If the controller has a pio mode setup function then use
-	   it to set the chipset to rights. Don't touch the DMA setup
-	   as that will be dealt with when revalidating */
-	if (ap->ops->set_piomode) {
-		ata_link_for_each_dev(dev, &ap->link)
-			if (devmask & (1 << i++))
-				ap->ops->set_piomode(ap, dev);
-	}
-
 	/* wait a while before checking status */
 	ata_wait_after_reset(ap, deadline);
 
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2083,6 +2083,25 @@ int ata_eh_reset(struct ata_link *link, 
 
 	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 
+	ata_link_for_each_dev(dev, link) {
+		/* If we issue an SRST then an ATA drive (not ATAPI)
+		 * may change configuration and be in PIO0 timing. If
+		 * we do a hard reset (or are coming from power on)
+		 * this is true for ATA or ATAPI. Until we've set a
+		 * suitable controller mode we should not touch the
+		 * bus as we may be talking too fast.
+		 */
+		dev->pio_mode = XFER_PIO_0;
+
+		/* If the controller has a pio mode setup function
+		 * then use it to set the chipset to rights. Don't
+		 * touch the DMA setup as that will be dealt with when
+		 * configuring devices.
+		 */
+		if (ap->ops->set_piomode)
+			ap->ops->set_piomode(ap, dev);
+	}
+
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
