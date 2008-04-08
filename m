From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Be a bit more slack about early devices
Date: Tue, 8 Apr 2008 16:36:44 +0100
Message-ID: <20080408163644.322f5a6d@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51156 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753077AbYDHPkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 11:40:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, akpm@osdl.org

We have a certain number of 'ATA' emulations often on CF or other flash
devices that are at best "loosely based" on the CF 1.1 standard. These
devices report themselves as disk but don't support the ATA minimal
command set only the CF 1.1 set.

Relax the PIO checking for devices reporting ATA rev 0, or no iordy
support, or CFA. Rework the code a bit as it was already messy and this
made it quite ugly.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 11:34:51.000000000 +0100
+++ linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 12:01:30.000000000 +0100
@@ -3342,16 +3342,21 @@
 	if (rc)
 		return rc;
 
-	/* Old CFA may refuse this command, which is just fine */
-	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
-		ign_dev_err = 1;
-
-	/* Some very old devices and some bad newer ones fail any kind of
-	   SET_XFERMODE request but support PIO0-2 timings and no IORDY */
-	if (dev->xfer_shift == ATA_SHIFT_PIO && !ata_id_has_iordy(dev->id) &&
-			dev->pio_mode <= XFER_PIO_2)
-		ign_dev_err = 1;
-
+	if (dev->xfer_shift == ATA_SHIFT_PIO) {
+		/* Old CFA may refuse this command, which is just fine */
+		if (ata_id_is_cfa(dev->id))
+			ign_dev_err = 1;
+		/* Catch several broken garbage emulations plus some pre
+		   ATA devices */
+		if (ata_id_major_version(dev->id) == 0 &&
+					dev->pio_mode <= XFER_PIO_2)
+			ign_dev_err = 1;
+		/* Some very old devices and some bad newer ones fail
+		   any kind of SET_XFERMODE request but support PIO0-2
+		   timings and no IORDY */
+		if (!ata_id_has_iordy(dev->id) && dev->pio_mode <= XFER_PIO_2)
+			ign_dev_err = 1;
+	}
 	/* Early MWDMA devices do DMA but don't allow DMA mode setting.
 	   Don't fail an MWDMA0 set IFF the device indicates it is in MWDMA0 */
 	if (dev->xfer_shift == ATA_SHIFT_MWDMA &&
