From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata: modify ata_dev_try_classify
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <11380899223675-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:44946 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030356AbWAXIFa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:30 -0500
Received: by zproxy.gmail.com with SMTP id 16so1219284nzp
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:28 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Make ata_dev_try_classify take @r_err to store tf error register value
on completion and return device class instead of directly manipulating
dev->class.  This is preparation for new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

0ac93b37ce5955cee51d85fa2810cb40b8909c33
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bc13729..e10169d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -830,6 +830,7 @@ unsigned int ata_dev_classify(const stru
  *	ata_dev_try_classify - Parse returned ATA device signature
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
+ *	@r_err: Value of error register on completion
  *
  *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
  *	an ATA/ATAPI-defined set of values is placed in the ATA
@@ -842,11 +843,14 @@ unsigned int ata_dev_classify(const stru
  *
  *	LOCKING:
  *	caller.
+ *
+ *	RETURNS:
+ *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
 
-static u8 ata_dev_try_classify(struct ata_port *ap, unsigned int device)
+static unsigned int
+ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 {
-	struct ata_device *dev = &ap->device[device];
 	struct ata_taskfile tf;
 	unsigned int class;
 	u8 err;
@@ -857,8 +861,8 @@ static u8 ata_dev_try_classify(struct at
 
 	ap->ops->tf_read(ap, &tf);
 	err = tf.feature;
-
-	dev->class = ATA_DEV_NONE;
+	if (r_err)
+		*r_err = err;
 
 	/* see if device passed diags */
 	if (err == 1)
@@ -866,18 +870,16 @@ static u8 ata_dev_try_classify(struct at
 	else if ((device == 0) && (err == 0x81))
 		/* do nothing */ ;
 	else
-		return err;
+		return ATA_DEV_NONE;
 
-	/* determine if device if ATA or ATAPI */
+	/* determine if device is ATA or ATAPI */
 	class = ata_dev_classify(&tf);
+
 	if (class == ATA_DEV_UNKNOWN)
-		return err;
+		return ATA_DEV_NONE;
 	if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
-		return err;
-
-	dev->class = class;
-
-	return err;
+		return ATA_DEV_NONE;
+	return class;
 }
 
 /**
@@ -2224,9 +2226,9 @@ void ata_bus_reset(struct ata_port *ap)
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
-- 
1.1.3


