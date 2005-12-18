From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata: modify ata_dev_try_classify
Date: Sun, 18 Dec 2005 22:36:09 +0900
Message-ID: <20051218133609.GB31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:51044 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932702AbVLRNgO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:36:14 -0500
Received: by zproxy.gmail.com with SMTP id 14so1714559nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:36:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Make ata_dev_try_classify take @perr to store Error register value on
completion and return device class instead of directly manipulating
dev->class.  This is preparation for new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Unless specifically noted, all patches are against upstream head as of
today (c6329f4df2263ab5a40601a5236639e61b682f51)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-18 20:16:38.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-18 20:16:57.000000000 +0900
@@ -811,6 +811,7 @@ unsigned int ata_dev_classify(const stru
  *	ata_dev_try_classify - Parse returned ATA device signature
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
+ *	@perr: Value of error register on completion
  *
  *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
  *	an ATA/ATAPI-defined set of values is placed in the ATA
@@ -823,11 +824,14 @@ unsigned int ata_dev_classify(const stru
  *
  *	LOCKING:
  *	caller.
+ *
+ *	RETURNS:
+ *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, or %ATA_DEV_NONE.
  */
 
-static u8 ata_dev_try_classify(struct ata_port *ap, unsigned int device)
+static unsigned int
+ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *perr)
 {
-	struct ata_device *dev = &ap->device[device];
 	struct ata_taskfile tf;
 	unsigned int class;
 	u8 err;
@@ -838,8 +842,8 @@ static u8 ata_dev_try_classify(struct at
 
 	ap->ops->tf_read(ap, &tf);
 	err = tf.feature;
-
-	dev->class = ATA_DEV_NONE;
+	if (perr)
+		*perr = err;
 
 	/* see if device passed diags */
 	if (err == 1)
@@ -847,18 +851,16 @@ static u8 ata_dev_try_classify(struct at
 	else if ((device == 0) && (err == 0x81))
 		/* do nothing */ ;
 	else
-		return err;
+		return ATA_DEV_NONE;
 
-	/* determine if device if ATA or ATAPI */
+	/* determine if device is ATA or ATAPI */
 	class = ata_dev_classify(&tf);
 	if (class == ATA_DEV_UNKNOWN)
-		return err;
-	if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
-		return err;
-
-	dev->class = class;
+		class = ATA_DEV_NONE;
+	else if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
+		class = ATA_DEV_NONE;
 
-	return err;
+	return class;
 }
 
 /**
@@ -2095,9 +2097,9 @@ void ata_bus_reset(struct ata_port *ap)
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	err = ata_dev_try_classify(ap, 0);
+	ap->device[0].class = ata_dev_try_classify(ap, 0, &err);
 	if ((slave_possible) && (err != 0x81))
-		ata_dev_try_classify(ap, 1);
+		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
