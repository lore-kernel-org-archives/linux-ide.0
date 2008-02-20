From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH RFC] libata-core: do something about flush cache
Date: Wed, 20 Feb 2008 21:45:08 +0000
Message-ID: <20080220214508.5aed05d9@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41976 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757499AbYBTVyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 16:54:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

The IDE layers assume a failed flush cache is a simple error, but it is
actually far more complicated. The spec says that an error is returned by
flush cache if a sector cannot be committed to disc. In that case the
failed sector is dropped from cache and the command reports the bad
sector. It does *not* automatically flush other sectors. Instead we must
re-issue the flush.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc2-mm1/drivers/ata/libata-core.c linux-2.6.25-rc2-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.25-rc2-mm1/drivers/ata/libata-core.c	2008-02-19 11:03:26.000000000 +0000
+++ linux-2.6.25-rc2-mm1/drivers/ata/libata-core.c	2008-02-20 11:56:25.000000000 +0000
@@ -6477,10 +6477,30 @@
 	return 0;
 }
 
+static void ata_flush_cache_error(u8 cmd, struct ata_device *dev,
+						struct ata_taskfile *tf)
+{
+	char *df = "";
+	u64 lba;
+
+	if (tf->command & ATA_DF)
+		df = " (device fault)";
+
+	if (cmd == ATA_CMD_FLUSH)
+		lba = ata_tf_to_lba(tf);
+	else
+		lba = ata_tf_to_lba48(tf);
+	
+	ata_dev_printk(dev, KERN_WARNING, "flush of sector %lld failed%s.\n",
+				lba, df);
+}
+
 int ata_flush_cache(struct ata_device *dev)
 {
 	unsigned int err_mask;
 	u8 cmd;
+	struct ata_taskfile tf;
+	int i;
 
 	if (!ata_try_flush_cache(dev))
 		return 0;
@@ -6490,17 +6510,32 @@
 	else
 		cmd = ATA_CMD_FLUSH;
 
-	/* This is wrong. On a failed flush we get back the LBA of the lost
-	   sector and we should (assuming it wasn't aborted as unknown) issue
-	   a further flush command to continue the writeback until it
-	   does not error */
-	err_mask = ata_do_simple_cmd(dev, cmd);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
-		return -EIO;
-	}
+	/* 20 failed flush sectors and we abandon hope. This is a heuristic
+	   we can twiddle later */
+	for (i = 0; i < 20; i++) {
+		ata_tf_init(dev, &tf);
+		tf.command = cmd;
+		tf.flags |= ATA_TFLAG_DEVICE;
+		tf.protocol = ATA_PROT_NODATA;
 
-	return 0;
+		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+
+		/* Flush completed without further errors */
+		if (err_mask == 0)
+			return 0;
+		/* Non device errors cannot be fixed by a retry at this
+		   level of the system */
+		if (err_mask != AC_ERR_DEV) {
+			ata_dev_printk(dev, KERN_ERR, "cache flush failed.\n");
+			return -EIO;
+		}
+		/* On a media error the bad block is reported and the flush
+		   stops. It will continue from after this sector when we
+		   reissue the command */
+		ata_flush_cache_error(cmd, dev, &tf);
+	}
+	ata_dev_printk(dev, KERN_ERR, "cache flush repeatedly failed.\n");
+	return -EIO;
 }
 
 #ifdef CONFIG_PM
