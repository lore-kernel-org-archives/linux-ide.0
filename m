From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Be a bit more relaxed about early DMA zero
 devices
Date: Mon, 15 Oct 2007 19:18:27 +0100
Message-ID: <20071015191827.26a3a76b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59926 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752989AbXJOSPt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 14:15:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

I guess Windows didn't care about the command so neither did they

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:13:49.000000000 +0100
@@ -2884,6 +2894,14 @@
 	if (dev->xfer_shift == ATA_SHIFT_PIO && !ata_id_has_iordy(dev->id) &&
 			dev->pio_mode <= XFER_PIO_2)
 		err_mask &= ~AC_ERR_DEV;
+
+	/* Early MWDMA devices do DMA but don't allow DMA mode setting.
+	   Don't fail an MWDMA0 set IFF the device indicates it is in MWDMA0 */
+	if (dev->xfer_shift == ATA_SHIFT_MWDMA && 
+	    dev->dma_mode == XFER_MW_DMA_0 &&
+	    (dev->id[63] >> 8) & 1)
+		err_mask &= ~AC_ERR_DEV;
+
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
@@ -3985,9 +4003,6 @@
 	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
-	{ "IOMEGA  ZIP 250       ATAPI", NULL,	ATA_HORKAGE_NODMA }, /* temporary fix */
-	{ "IOMEGA  ZIP 250       ATAPI       Floppy",
-				NULL,		ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
 	{ "Config  Disk",	NULL,		ATA_HORKAGE_NODMA |
 						ATA_HORKAGE_SKIP_PM },
