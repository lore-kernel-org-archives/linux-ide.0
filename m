From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Drop in the final bit of IORDY handling
Date: Mon, 15 Oct 2007 19:20:40 +0100
Message-ID: <20071015192040.5a11bcf7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59929 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757015AbXJOSQp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 14:16:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:13:49.000000000 +0100
@@ -4203,8 +4219,12 @@
 	tf.command = ATA_CMD_SET_FEATURES;
 	tf.feature = SETFEATURES_XFER;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_POLLING;
 	tf.protocol = ATA_PROT_NODATA;
-	tf.nsect = dev->xfer_mode;
+ 	/* Ancient devices may need us to avoid IORDY */
+ 	if (ata_pio_need_iordy(dev))
+ 		tf.nsect = dev->xfer_mode;
+ 	else
+ 		tf.nsect = 0x01;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 
