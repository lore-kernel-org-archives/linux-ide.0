From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ahci: Invalid use of writel/readl with iomap
Date: Mon, 19 Nov 2007 14:28:28 +0000
Message-ID: <20071119142828.4fe4ee55@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58374 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755355AbXKSOaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:30:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

Should use ioread* as discussed previously

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/ata_piix.c linux-2.6.24-rc2-mm1/drivers/ata/ata_piix.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/ata_piix.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/ata_piix.c	2007-11-16 18:11:02.000000000 +0000
@@ -1086,12 +1086,12 @@
 	if (!mmio)
 		return -ENOMEM;
 
-	tmp = readl(mmio + AHCI_GLOBAL_CTL);
+	tmp = ioread32(mmio + AHCI_GLOBAL_CTL);
 	if (tmp & AHCI_ENABLE) {
 		tmp &= ~AHCI_ENABLE;
-		writel(tmp, mmio + AHCI_GLOBAL_CTL);
+		iowrite32(tmp, mmio + AHCI_GLOBAL_CTL);
 
-		tmp = readl(mmio + AHCI_GLOBAL_CTL);
+		tmp = ioread32(mmio + AHCI_GLOBAL_CTL);
 		if (tmp & AHCI_ENABLE)
 			rc = -EIO;
 	}
