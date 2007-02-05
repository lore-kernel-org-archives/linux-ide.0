From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-eh: Add a simple mechanism for silencing error
 reporting
Date: Mon, 5 Feb 2007 16:11:24 +0000
Message-ID: <20070205161124.48bf16c6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54743 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751409AbXBEP6o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 10:58:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, htejun@gmail.com

We want to be able to issue commands that fail silently some of the time
(set_features/xfer rate to CF 1.4 devices, perhaps some others such as
user SG_IO commands ought to be silent too as the error is for the app)

This is a minimal implementation, we can extend it so the QUIET flag
isn't quiet about errors that are not command errors but indicate
infrastructre problems (CRC errors, HSM violation, DeviceFault) if need
be.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-eh.c linux-2.6.20-rc6-mm3/drivers/ata/libata-eh.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-eh.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/libata-eh.c	2007-01-31 14:27:25.000000000 +0000
@@ -1407,6 +1407,8 @@
 			continue;
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
 			continue;
+		if (qc->tf.flags & ATA_TFLAG_QUIET)
+			continue;
 
 		nr_failed++;
 	}
@@ -1446,6 +1448,8 @@
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
 			continue;
+		if (qc->tf.flags & ATA_TFLAG_QUIET)
+			continue;
 
 		ata_dev_printk(qc->dev, KERN_ERR,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/include/linux/ata.h linux-2.6.20-rc6-mm3/include/linux/ata.h
--- linux.vanilla-2.6.20-rc6-mm3/include/linux/ata.h	2007-01-31 14:20:43.000000000 +0000
+++ linux-2.6.20-rc6-mm3/include/linux/ata.h	2007-02-05 10:53:45.000000000 +0000
@@ -232,6 +232,7 @@
 	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
 	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
 	ATA_TFLAG_POLLING	= (1 << 6), /* set nIEN to 1 and use polling */
+	ATA_TFLAG_QUIET		= (1 << 7), /* don't log rejection */
 };
 
 enum ata_tf_protocols {
