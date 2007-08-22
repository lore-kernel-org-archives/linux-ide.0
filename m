From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_marvell: Add another PCI identifier
Date: Wed, 22 Aug 2007 23:27:05 +0100
Message-ID: <20070822232705.2decea96@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44109 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761396AbXHVWTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 18:19:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_marvell.c linux-2.6.23rc3-mm1/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_marvell.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_marvell.c	2007-08-22 17:46:28.000000000 +0100
@@ -190,7 +190,8 @@
 
 static const struct pci_device_id marvell_pci_tbl[] = {
 	{ PCI_DEVICE(0x11AB, 0x6101), },
-	{ PCI_DEVICE(0x11AB, 0x6145), },
+	{ PCI_DEVICE(0x11AB, 0x6121), },
+	{ PCI_DEVICE(0x11AB, 0x6123), },
 	{ }	/* terminate list */
 };
 
