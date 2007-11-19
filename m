From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: IORDY handling
Date: Mon, 19 Nov 2007 14:33:11 +0000
Message-ID: <20071119143311.606d88fd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33656 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753022AbXKSOfF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:35:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

I believe this version meets all Sergei's objections

Correct the logic for when we issue a set features for transfer mode

- If the device has IORDY and the controller has IORDY - set the mode
- If the device has IORDY and the controller does not - turn IORDY off
- If neither has IORDY do nothing

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-core.c linux-2.6.24-rc2-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-core.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/libata-core.c	2007-11-16 23:42:27.000000000 +0000
@@ -4392,7 +4400,14 @@
 	tf.feature = SETFEATURES_XFER;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_POLLING;
 	tf.protocol = ATA_PROT_NODATA;
-	tf.nsect = dev->xfer_mode;
+	/* If we are using IORDY we must send the mode setting command */
+ 	if (ata_pio_need_iordy(dev))
+ 		tf.nsect = dev->xfer_mode;
+	/* If the device has IORDY and the controller does not - turn it off */
+ 	else if (ata_id_has_iordy(dev->id))
+ 		tf.nsect = 0x01;
+	else /* In the ancient relic department - skip all of this */
+		return 0;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 
