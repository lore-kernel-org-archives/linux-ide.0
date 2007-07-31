From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Correct IORDY handling
Date: Tue, 31 Jul 2007 14:01:48 +0100
Message-ID: <20070731140148.4cb780de@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52038 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757967AbXGaMyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 08:54:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Debugging a report of a problem with an ancient solid state disk showed
up some problems in the IORDY handling

1.	We check the wrong bit to see if the device has IORDY
2.	Even then some ancient creaking piles of crap don't support
	SETXFER at all.

I think this should go via -mm for a bit. The cases it fixes are obscure
and the risk of side effects is slight but possible. This also moves us
slightly closer to supporting original MFM/RLL disks with libata but
before Jeff panics I have no plans to do that....

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c linux-2.6.23rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-26 15:02:57.000000000 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-31 10:47:21.152431008 +0100
@@ -2787,7 +2803,11 @@
 	/* Old CFA may refuse this command, which is just fine */
 	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
         	err_mask &= ~AC_ERR_DEV;
-
+	/* Some very old devices and some bad newer ones fail any kind of
+	   SET_XFERMODE request but support PIO0-2 timings and no IORDY */
+	if (dev->xfer_shift == ATA_SHIFT_PIO && !ata_id_has_iordy(dev->id) &&
+			dev->pio_mode <= XFER_PIO_2)
+		err_mask &= ~AC_ERR_DEV;
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/include/linux/ata.h linux-2.6.23rc1-mm1/include/linux/ata.h
--- linux.vanilla-2.6.23rc1-mm1/include/linux/ata.h	2007-07-26 15:02:58.000000000 +0100
+++ linux-2.6.23rc1-mm1/include/linux/ata.h	2007-07-27 19:03:40.000000000 +0100
@@ -354,7 +355,7 @@
 	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
 	  ((id)[78] & (1 << 5)) )
 #define ata_id_iordy_disable(id) ((id)[49] & (1 << 10))
-#define ata_id_has_iordy(id) ((id)[49] & (1 << 9))
+#define ata_id_has_iordy(id) ((id)[49] & (1 << 11))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
