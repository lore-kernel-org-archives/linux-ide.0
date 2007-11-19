From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt37x: Fix cable detect bug spotted by Sergei
Date: Mon, 19 Nov 2007 14:39:13 +0000
Message-ID: <20071119143913.078738ed@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37826 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753430AbXKSOlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:41:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c linux-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c	2007-11-16 18:14:19.000000000 +0000
@@ -329,7 +329,7 @@
 	/* Restore state */
 	pci_write_config_byte(pdev, 0x5B, scr2);
 
-	if (ata66 & (1 << ap->port_no))
+	if (ata66 & (2 >> ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
