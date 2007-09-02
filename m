From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2 #upstream,REGENERATED] libata: udpate ata_dev_try_classify() arguments
Date: Sun, 2 Sep 2007 23:23:57 +0900
Message-ID: <20070902142357.GA21527@htj.dyndns.org>
References: <20070808053739.GS13674@htj.dyndns.org> <46D7DCE5.8090700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:62536 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbXIBOYE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 10:24:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1586361wah
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 07:24:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46D7DCE5.8090700@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, amsden_linux@earthlink.net

Make ata_dev_try_classify() take a pointer to ata_device instead of
ata_port/port_number combination for consistency and add @present
argument.  @present indicates whether the device seems present during
reset.  It's the result of TF access during softreset and link
onlineness during hardreset.  @present will be used to improve
diagnostic failure handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   30 ++++++++++++++++--------------
 drivers/ata/pata_scc.c    |    6 ++++--
 drivers/ata/sata_mv.c     |    2 +-
 include/linux/libata.h    |    3 ++-
 4 files changed, 23 insertions(+), 18 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -701,8 +701,8 @@ unsigned int ata_dev_classify(const stru
 
 /**
  *	ata_dev_try_classify - Parse returned ATA device signature
- *	@ap: ATA channel to examine
- *	@device: Device to examine (starting at zero)
+ *	@dev: ATA device to classify (starting at zero)
+ *	@present: device seems present
  *	@r_err: Value of error register on completion
  *
  *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
@@ -720,15 +720,15 @@ unsigned int ata_dev_classify(const stru
  *	RETURNS:
  *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
-
-unsigned int
-ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
+unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
+				  u8 *r_err)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 	unsigned int class;
 	u8 err;
 
-	ap->ops->dev_select(ap, device);
+	ap->ops->dev_select(ap, dev->devno);
 
 	memset(&tf, 0, sizeof(tf));
 
@@ -738,12 +738,12 @@ ata_dev_try_classify(struct ata_port *ap
 		*r_err = err;
 
 	/* see if device passed diags: if master then continue and warn later */
-	if (err == 0 && device == 0)
+	if (err == 0 && dev->devno == 0)
 		/* diagnostic fail : do nothing _YET_ */
-		ap->link.device[device].horkage |= ATA_HORKAGE_DIAGNOSTIC;
+		dev->horkage |= ATA_HORKAGE_DIAGNOSTIC;
 	else if (err == 1)
 		/* do nothing */ ;
-	else if ((device == 0) && (err == 0x81))
+	else if ((dev->devno == 0) && (err == 0x81))
 		/* do nothing */ ;
 	else
 		return ATA_DEV_NONE;
@@ -3212,9 +3212,9 @@ void ata_bus_reset(struct ata_port *ap)
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	device[0].class = ata_dev_try_classify(ap, 0, &err);
+	device[0].class = ata_dev_try_classify(&device[0], dev0, &err);
 	if ((slave_possible) && (err != 0x81))
-		device[1].class = ata_dev_try_classify(ap, 1, &err);
+		device[1].class = ata_dev_try_classify(&device[1], dev1, &err);
 
 	/* is double-select really necessary? */
 	if (device[1].class != ATA_DEV_NONE)
@@ -3453,9 +3453,11 @@ int ata_std_softreset(struct ata_link *l
 	}
 
 	/* determine by signature whether we have ATA or ATAPI devices */
-	classes[0] = ata_dev_try_classify(ap, 0, &err);
+	classes[0] = ata_dev_try_classify(&link->device[0],
+					  devmask & (1 << 0), &err);
 	if (slave_possible && err != 0x81)
-		classes[1] = ata_dev_try_classify(ap, 1, &err);
+		classes[1] = ata_dev_try_classify(&link->device[1],
+						  devmask & (1 << 1), &err);
 
  out:
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
@@ -3574,7 +3576,7 @@ int sata_std_hardreset(struct ata_link *
 
 	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
 
-	*class = ata_dev_try_classify(ap, 0, NULL);
+	*class = ata_dev_try_classify(link->device, 1, NULL);
 
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
Index: work/drivers/ata/pata_scc.c
===================================================================
--- work.orig/drivers/ata/pata_scc.c
+++ work/drivers/ata/pata_scc.c
@@ -636,9 +636,11 @@ static int scc_std_softreset (struct ata
 	}
 
 	/* determine by signature whether we have ATA or ATAPI devices */
-	classes[0] = ata_dev_try_classify(ap, 0, &err);
+	classes[0] = ata_dev_try_classify(&ap->link.device[0],
+					  devmask & (1 << 0), &err);
 	if (slave_possible && err != 0x81)
-		classes[1] = ata_dev_try_classify(ap, 1, &err);
+		classes[1] = ata_dev_try_classify(&ap->link.device[1],
+						  devmask & (1 << 1), &err);
 
  out:
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
Index: work/drivers/ata/sata_mv.c
===================================================================
--- work.orig/drivers/ata/sata_mv.c
+++ work/drivers/ata/sata_mv.c
@@ -2224,7 +2224,7 @@ comreset_retry:
 	 */
 
 	/* finally, read device signature from TF registers */
-	*class = ata_dev_try_classify(ap, 0, NULL);
+	*class = ata_dev_try_classify(ap->link.device, 1, NULL);
 
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -781,7 +781,8 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
-extern unsigned int ata_dev_try_classify(struct ata_port *, unsigned int, u8 *);
+extern unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
+					 u8 *r_err);
 
 /*
  * Default driver ops implementations
