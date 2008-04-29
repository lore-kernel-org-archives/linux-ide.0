From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_via: Fix 6410 misdetect
Date: Tue, 29 Apr 2008 14:10:57 +0100
Message-ID: <20080429141057.650e6b0a@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42058 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751781AbYD2NS1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 09:18:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

The discrete VIA ATA chips don't have 0x40 enable bits. We check that
properly in one location but not another. This causes some users 6410
RAID cards to be incorrectly skipped.

Would be good if this made the next kernel (may also be appropriate for
stable)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-mm1/drivers/ata/pata_via.c linux-2.6.25-mm1/drivers/ata/pata_via.c
--- linux.vanilla-2.6.25-mm1/drivers/ata/pata_via.c	2008-04-28 11:36:48.000000000 +0100
+++ linux-2.6.25-mm1/drivers/ata/pata_via.c	2008-04-29 10:16:07.000000000 +0100
@@ -464,11 +464,12 @@
 	}
 	pci_dev_put(isa);
 
-	/* 0x40 low bits indicate enabled channels */
-	pci_read_config_byte(pdev, 0x40 , &enable);
-	enable &= 3;
-	if (enable == 0) {
-		return -ENODEV;
+	if (!(config->flags & VIA_NO_ENABLES)) {
+		/* 0x40 low bits indicate enabled channels */
+		pci_read_config_byte(pdev, 0x40 , &enable);
+		enable &= 3;
+		if (enable == 0)
+			return -ENODEV;
 	}
 
 	/* Initialise the FIFO for the enabled channels. */
