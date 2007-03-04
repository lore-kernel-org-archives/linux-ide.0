From: Mark Lord <liml@rtr.ca>
Subject: [PATCH/RFC]: recovery from power-up-in-standby feature
Date: Sun, 04 Mar 2007 15:43:25 -0500
Message-ID: <45EB2F6D.7050407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4699 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbXCDUn3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Mar 2007 15:43:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

ATA/SATA drives can be set to not spinup automatically at power-on,
for use in staggered spin-up applications where frying power supplies
is to be avoided.

These drives may return incomplete IDENTIFY responses
until they have been spun-up first by the device driver.

There are two ways this happens, and the drive lets us know
which it expects based on the initial, partial IDENTIFY response.

(1) The old method (34GB WD Raptor drives) will spin up on receipt of
any media-access command.  The trick here being, we that don't have
full IDENTIFY info to properly issue just *any* media command,
so this has to be controlled carefully.

(2) The more common method is for the drive to require an explicit
set-features "spin-up" subcommand after the IDENTIFY.

The patch below implements the latter method (tested, works for me).

But as you can see, there is an "#if 0 FIXME" section around
the code which attempts to deal with the "spin up on any media access"
variant of this protocol.  That code just doesn't work for me,
and I'm hoping Jeff/Tejun might be able to point out where it's gone silly.

I could/should just remove that part and submit the rest,
but it would be better to understand why it fails and fix it.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
diff -u --recursive --new-file --exclude-from=linux-2.6.20//Documentation/dontdiff linux-2.6.20/drivers/ata/libata-core.c linux/drivers/ata/libata-core.c
--- linux-2.6.20/drivers/ata/libata-core.c	2007-02-04 13:44:54.000000000 -0500
+++ linux/drivers/ata/libata-core.c	2007-02-22 15:19:41.000000000 -0500
@@ -1453,6 +1453,7 @@
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
 	const char *reason;
+	int tried_spinup = 0;
 	int rc;
 
 	if (ata_msg_ctl(ap))
@@ -1460,7 +1461,6 @@
 			       __FUNCTION__, ap->id, dev->devno);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
-
  retry:
 	ata_tf_init(dev, &tf);
 
@@ -1508,6 +1508,32 @@
 			goto err_out;
 	}
 
+	if (!tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
+		tried_spinup = 1;
+		/*
+		 * Drive powered-up in standby mode, and requires a specific
+		 * SET_FEATURES spin-up subcommand before it will accept
+		 * anything other than the original IDENTIFY command.
+		 */
+		ata_tf_init(dev, &tf);
+		tf.command = ATA_CMD_SET_FEATURES;
+		tf.feature = SETFEATURES_SPINUP;
+		tf.protocol = ATA_PROT_NODATA;
+		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+		if (err_mask) {
+			rc = -EIO;
+			reason = "SPINUP failed";
+			goto err_out;
+		}
+		/*
+		 * If the drive initially returned incomplete IDENTIFY info,
+		 * we now must reissue the IDENTIFY command.
+		 */
+		if (id[2] == 0x37c8)
+			goto retry;
+	}
+
 	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
@@ -1532,6 +1558,42 @@
 			goto retry;
 		}
 	}
+#if 0
+	/*
+	 * FIXME: this always fails with AC_ERR_DEV,
+	 * even when issued on a spun-up drive
+	 * (accomplished by commenting out the if-stmt below).
+	 *
+	 * What's wrong here???
+	 */
+	if (!tried_spinup && id[2] == 0x8c73)
+	{
+		tried_spinup = 1;
+		/*
+		 * Drive powered up in standby mode, and returned only
+		 * partial IDENTIFY data.  This requires a media access
+		 * command (to force a spin-up) before the drive can
+		 * return a complete set of IDENTIFY data.
+		 * Here, we use READ_VERIFY(LBA=0) to force the spin-up.
+		 */
+		ata_tf_init(dev, &tf);
+		tf.command = ATA_CMD_VERIFY;
+		tf.nsect = 1;
+		tf.protocol = ATA_PROT_NODATA;
+		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA;
+		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+		//printk("VERIFY(0): err_mask=0x%x\n", err_mask);
+		if (err_mask) {
+			rc = -EIO;
+			reason = "VERIFY(spin-up) failed";
+			goto err_out;
+		}
+		/*
+		 * Reissue the IDENTIFY command.
+		 */
+		goto retry;
+	}
+#endif /* FIXME */
 
 	*p_class = class;
 
diff -u --recursive --new-file --exclude-from=linux-2.6.20//Documentation/dontdiff linux-2.6.20/include/linux/ata.h linux/include/linux/ata.h
--- linux-2.6.20/include/linux/ata.h	2007-02-04 13:44:54.000000000 -0500
+++ linux/include/linux/ata.h	2007-02-22 13:52:45.000000000 -0500
@@ -190,6 +190,8 @@
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
+	SETFEATURES_SPINUP	= 0x07,
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
