From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pdc202xx_old: LBA48 bug
Date: Fri, 23 Mar 2007 18:57:23 +0000
Message-ID: <20070323185723.02388672@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35168 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933931AbXCWRx6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 13:53:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

In LBA48 mode we have to help the controller to get anything to work. The
chip provides a register giving word counts meant for ATAPI use which we
can use. However we need to load the count in words not bytes..

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc4-mm1/drivers/ata/pata_pdc202xx_old.c linux-2.6.21-rc4-mm1/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.21-rc4-mm1/drivers/ata/pata_pdc202xx_old.c	2007-03-23 11:49:49.000000000 +0000
+++ linux-2.6.21-rc4-mm1/drivers/ata/pata_pdc202xx_old.c	2007-03-23 13:21:54.000000000 +0000
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_pdc202xx_old"
-#define DRV_VERSION "0.4.2"
+#define DRV_VERSION "0.4.3"
 
 static int pdc2026x_cable_detect(struct ata_port *ap)
 {
@@ -167,7 +167,7 @@
 	/* Cases the state machine will not complete correctly without help */
 	if ((tf->flags & ATA_TFLAG_LBA48) ||  tf->protocol == ATA_PROT_ATAPI_DMA)
 	{
-		len = qc->nbytes;
+		len = qc->nbytes / 2;
 
 		if (tf->flags & ATA_TFLAG_WRITE)
 			len |= 0x06000000;
